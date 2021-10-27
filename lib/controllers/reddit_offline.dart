import 'dart:convert';
import 'package:app/models/reddit_post.dart';
import 'package:http/http.dart';

enum OfflineGetType {
  newest,
  rising,
  top,
  hot,
  controversial
}

class RedditOffline {
  factory RedditOffline() => _this ??= RedditOffline._();

  static RedditOffline? _this;
  static const String _base = "reddit.com";
  static const Map<OfflineGetType, String> _path = {
    OfflineGetType.newest: "/new.json",
    OfflineGetType.rising: "/rising.json",
    OfflineGetType.top: "/top.json",
    OfflineGetType.hot: "/hot.json",
    OfflineGetType.controversial: "/controversial.json"
  };

  final Map<OfflineGetType, String> _last = {
    OfflineGetType.newest: "",
    OfflineGetType.rising: "",
    OfflineGetType.top: "",
    OfflineGetType.hot: "",
    OfflineGetType.controversial: ""
  };

  RedditOffline._();

  void resetPosts(OfflineGetType type) {
    _last[type] = "";
  }

  Stream<RedditPost> getPosts(OfflineGetType type, {int limits = 100}) async* {
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