import 'package:app/models/reddit_data.dart';
import 'package:app/models/reddit_post.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

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
  late RedditData _model;

  RedditClient._()
  {
    _model = RedditData();
  }

  bool get isConnected => _model.isConnected;

  Redditor? get me => _model.me;

  void resetPosts(PostType type) {
    _last[type] = "";
  }

  Stream<RedditPost> getPosts(PostType type, {int limits = 100}) async* {
    Stream<UserContent> stream;

    switch (type) {
      case PostType.controversial:
        {
          stream = _model.reddit.front.controversial();
        }
        break;

      case PostType.hot:
        {
          stream = _model.reddit.front.hot();
        }
        break;

      case PostType.newest:
        {
          stream = _model.reddit.front.newest();
        }
        break;

      case PostType.rising:
        {
          stream = _model.reddit.front.rising();
        }
        break;

      case PostType.top:
        {
          stream = _model.reddit.front.top();
        }
        break;
    }
    await for (final event in stream) {
      var submission = event as Submission;

      yield RedditPost.fromJson(submission.data as Map<String, dynamic>);
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
}