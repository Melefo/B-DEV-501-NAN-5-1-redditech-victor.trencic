import 'package:app/models/reddit_prefs.dart';
import 'package:draw/draw.dart';
import 'package:app/extensions/subroddit.dart';

extension Rodditor on Redditor {

  String? get iconImg => data?["icon_img"]?.split("?")[0];

  Subreddit? get _subreddit =>
      data?["subreddit"] != null ? Subreddit.parse(
          reddit, {"data": data!["subreddit"]}) : null;

  String? get description => _subreddit?.publicDescription;

  String? get bannerImg =>
      _subreddit?.mobileHeaderImage?.hasAbsolutePath == true ? _subreddit
          ?.mobileHeaderImage.toString().split("?")[0] : null;

  String get username => _subreddit?.title ?? displayName;

  Stream<Subreddit> get subreddits => reddit.user.subreddits();

  Future<RedditPrefs> get prefs async =>
      RedditPrefs(await reddit.get("api/v1/me/prefs", objectify: false));
}