import 'dart:convert';

import 'package:app/wrapper/RedditPost.dart';
import 'package:app/wrapper/RedditUrl.dart';
import 'package:http/http.dart';

class RedditWrapper {
  //static String _lastHot = "";

  static Stream<List<RedditPost>> getFrontHots({int limits: 25}) async* {
    Response res = await get(RedditUrl.getHot({"limits": limits.toString()}));

    if (res.statusCode != 200)
      return;
    var json = jsonDecode(res.body);
    var list = List<RedditPost>.from(json["data"]['children'].map((model) =>
        RedditPost.fromJson(model["data"])));
    yield list;
  }
}