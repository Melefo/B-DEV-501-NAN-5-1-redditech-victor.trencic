class RedditUrl {
  static const String _base = "reddit.com";

  static Uri getHot([Map<String, dynamic>? queryParameters]) =>
    Uri.https(_base, "/hot.json", queryParameters);

  static Uri best = Uri.parse(_base + "/best.json");
  static Uri newest = Uri.parse(_base + "/new.json");
  static Uri rising = Uri.parse(_base + "/rising.json");
  static Uri top = Uri.parse(_base + "/top.json");
}