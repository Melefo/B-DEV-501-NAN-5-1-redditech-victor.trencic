import 'dart:convert';
import 'package:app/models/reddit_data.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:app/models/reddit_post.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

enum PostType {
  newest,
  rising,
  top,
  hot,
  controversial
}

class RedditClient extends ControllerMVC {
  factory RedditClient() => _this ??= RedditClient._();

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

  RedditClient._() {
    _model = RedditData();
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

  Stream<RedditPost> getSubPosts(String name, PostType type, {int limits = 25}) async* {
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

      yield RedditPost.fromJson(submission.data as Map<String, dynamic>);
      if (!_last.containsKey(name)) {
        _subLast[name] = <PostType, String>{};
      }
      _subLast[name]![type] = "t3_" + submission.id!;
    }
  }

    Stream<RedditPost> getFrontPosts(PostType type, {int limits = 25}) async* {
    Stream<UserContent> stream;

    switch (type) {
      case PostType.controversial:
        {
          stream = _model.reddit.front.controversial(limit: limits, after: _last[type]);
        }
        break;

      case PostType.hot:
        {
          stream = _model.reddit.front.hot(limit: limits, after: _last[type]);
        }
        break;

      case PostType.newest:
        {
          stream = _model.reddit.front.newest(limit: limits, after: _last[type]);
        }
        break;

      case PostType.rising:
        {
          stream = _model.reddit.front.rising(limit: limits, after: _last[type]);
        }
        break;

      case PostType.top:
        {
          stream = _model.reddit.front.top(limit: limits, after: _last[type]);
        }
        break;
    }
    await for (final event in stream) {
      var submission = event as Submission;

      yield RedditPost.fromJson(submission.data as Map<String, dynamic>);
      _last[type] = "t3_" + submission.id!;
    }
  }

    Future<void> connect(BuildContext context) async {
    try {
      var auth = await FlutterWebAuth.authenticate(
          url: _model.authUrl.toString(),
          callbackUrlScheme: _model.userAgent.toLowerCase());
      String? code = Uri
          .parse(auth)
          .queryParameters["code"];
      await _model.reddit.auth.authorize(code.toString());
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