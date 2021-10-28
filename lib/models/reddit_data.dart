import 'package:draw/draw.dart';

class RedditData {
  late Reddit reddit;
  late Uri authUrl;
  String userAgent = const String.fromEnvironment("REDDIT_USER_AGENT");
  Redditor? me;

  RedditData() {
    reddit = Reddit.createInstalledFlowInstance(
        clientId: const String.fromEnvironment("REDDIT_CLIENT_ID"),
        userAgent: userAgent,
        redirectUri: Uri.parse(const String.fromEnvironment("REDDIT_REDIRECT_URI"))
    );

    authUrl = reddit.auth.url(["*"], userAgent, compactLogin: true);
  }

  bool get isConnected =>
    me != null;
}