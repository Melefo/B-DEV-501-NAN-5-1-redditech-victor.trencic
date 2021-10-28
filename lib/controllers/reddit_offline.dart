import 'dart:convert';
import 'package:app/controllers/reddit_client.dart';
import 'package:app/models/reddit_post.dart';
import 'package:http/http.dart';

class RedditOffline {
  factory RedditOffline() => _this ??= RedditOffline._();

  static RedditOffline? _this;
  static const String _base = "reddit.com";
  static const Map<PostType, String> _path = {
    PostType.newest: "/new.json",
    PostType.rising: "/rising.json",
    PostType.top: "/top.json",
    PostType.hot: "/hot.json",
    PostType.controversial: "/controversial.json"
  };

  final Map<PostType, String> _last = {
    PostType.newest: "",
    PostType.rising: "",
    PostType.top: "",
    PostType.hot: "",
    PostType.controversial: ""
  };

  RedditOffline._();

  void resetPosts(PostType type) {
    _last[type] = "";
  }

  Stream<RedditPost> getPosts(PostType type, {int limits = 25}) async* {
    Response res = await get(Uri.https(_base, _path[type]!, {
      "limits": limits.toString(),
      "after": _last[type]
    }));

    if (res.statusCode != 200) {
      return;
    }
    var json = jsonDecode(res.body);
    for (var model in json["data"]["children"]) {
      RedditPost post = RedditPost.fromJson(model["data"]);
      yield post;
      _last[type] = post.id;
    }
  }
}