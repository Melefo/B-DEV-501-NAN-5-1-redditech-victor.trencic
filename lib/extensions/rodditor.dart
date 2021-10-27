import 'package:app/models/reddit_prefs.dart';
import 'package:draw/draw.dart';

extension Rodditor on Redditor {

  String? get iconImg => data?["icon_img"]?.split("?")[0];

  String? get description => data?["subreddit"]?["public_description"];

  String? get bannerImg => data?["subreddit"]?["banner_img"]?.split("?")[0];

  String get username => data?["subreddit"]?["title"] ?? displayName;

  Stream<Subreddit> get subreddits => reddit.user.subreddits();

  Future<RedditPrefs> get prefs async =>
      RedditPrefs(await reddit.get("api/v1/me/prefs", objectify: false));
}