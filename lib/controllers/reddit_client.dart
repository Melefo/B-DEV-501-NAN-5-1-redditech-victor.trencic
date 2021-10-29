import 'dart:convert';
import 'package:app/main.dart';
import 'package:app/models/reddit_data.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

enum PostType {
  newest,
  rising,
  top,
  hot,
  controversial
}

class RedditClient extends ControllerMVC {
  factory RedditClient({String? token}) =>
      _this ??= RedditClient._(token: token);

  static RedditClient? _this;
  final Map<PostType, String> _last = {
    PostType.newest: "",
    PostType.rising: "",
    PostType.top: "",
    PostType.hot: "",
    PostType.controversial: ""
  };
  final Map<String, Map<PostType, String>> _subLast = {
  };

  late RedditData _model;
  late Reddit _modelDisconnect;

  static Future<void> init({String? token}) async {
    var client = RedditClient(token: token);
    String? uuid = await Roddit.storage.read(key: RedditData.uuidKey);
    if (uuid == null) {
      uuid = const Uuid().v4();
      await Roddit.storage.write(key: RedditData.uuidKey, value: uuid);
    }
    client._modelDisconnect = await Reddit.createUntrustedReadOnlyInstance(
        clientId: const String.fromEnvironment("REDDIT_CLIENT_ID"),
        deviceId: uuid,
        userAgent: RedditData.userAgent
    );
    if (token != null) {
      client._model.me = await client._model.reddit.user.me();
    }
  }

  Reddit get test => _modelDisconnect;

  RedditClient._({String? token}) {
    _model = RedditData(token: token);
  }

  bool get isConnected => _model.isConnected;

  Redditor? get me => _model.me;

  void resetPosts(PostType type) {
    _last[type] = "";
  }

  void resetSubPosts(String name, PostType type) {
    if (_subLast.containsKey(name)) {
      _subLast[name]![type] = "";
    }
  }

  Stream<Submission> getSubPosts(String name, PostType type,
      {int limits = 25}) async* {
    var sub = _model.reddit.subreddit(name);
    Stream<UserContent> stream;

    switch (type) {
      case PostType.controversial:
        {
          stream = sub.controversial(
              limit: limits, after: _subLast[name]?[type] ?? "");
        }
        break;

      case PostType.hot:
        {
          stream = sub.hot(limit: limits, after: _subLast[name]?[type] ?? "");
        }
        break;

      case PostType.newest:
        {
          stream =
              sub.newest(limit: limits, after: _subLast[name]?[type] ?? "");
        }
        break;

      case PostType.rising:
        {
          stream =
              sub.rising(limit: limits, after: _subLast[name]?[type] ?? "");
        }
        break;

      case PostType.top:
        {
          stream = sub.top(limit: limits, after: _subLast[name]?[type] ?? "");
        }
        break;
    }

    await for (final event in stream) {
      var submission = event as Submission;

      yield submission;
      if (!_last.containsKey(name)) {
        _subLast[name] = <PostType, String>{};
      }
      _subLast[name]![type] = "t3_" + submission.id!;
    }
  }

  Stream<Submission> getFrontPosts(PostType type, {int limits = 25}) async* {
    var reddit = isConnected ? _model.reddit : _modelDisconnect;
    Stream<UserContent> stream;

    switch (type) {
      case PostType.controversial:
        {
          stream = reddit.front.controversial(
              limit: limits, after: _last[type]);
        }
        break;

      case PostType.hot:
        {
          stream = reddit.front.hot(limit: limits, after: _last[type]);
        }
        break;

      case PostType.newest:
        {
          stream =
              reddit.front.newest(limit: limits, after: _last[type]);
        }
        break;

      case PostType.rising:
        {
          stream =
              reddit.front.rising(limit: limits, after: _last[type]);
        }
        break;

      case PostType.top:
        {
          stream = reddit.front.top(limit: limits, after: _last[type]);
        }
        break;
    }
    await for (final event in stream) {
      var submission = event as Submission;

      yield submission;
      _last[type] = "t3_" + submission.id!;
    }
  }

  Future<void> connect(BuildContext context) async {
    try {
      var auth = await FlutterWebAuth.authenticate(
          url: _model.authUrl.toString(),
          callbackUrlScheme: RedditData.userAgent.toLowerCase());
      String? code = Uri
          .parse(auth)
          .queryParameters["code"];
      await _model.reddit.auth.authorize(code.toString());
      await Roddit.storage.write(
          key: RedditData.tokenKey,
          value: _model.reddit.auth.credentials.toJson()
      );
      _model.me = await _model.reddit.user.me();
      Navigator.pop(context);
    }
    catch (_) {
      _model = RedditData();
      Navigator.pop(context);
      return;
    }
  }

  Future<void> savePrefs(RedditPrefs prefs) async {
    var res = await http.patch(Uri.https("oauth.reddit.com", "api/v1/me/prefs"),
        headers: {
          "Authorization": "Bearer ${_model.reddit.auth.credentials
              .accessToken}",
          "Content-Type": "application/json"
        }, body: json.encode(prefs.data));
    if (res.statusCode != 200) {
      throw DRAWAuthenticationError("Can't save user prefs");
    }
  }
}