import 'package:draw/draw.dart';

class RedditData {
  late Reddit reddit;
  late Uri authUrl;
  static String tokenKey = "user_token";
  static String uuidKey = "user_uuid";
  static String userAgent = const String.fromEnvironment("REDDIT_USER_AGENT");
  Redditor? me;

  RedditData({String? token}) {
    if (token == null) {
      reddit = Reddit.createInstalledFlowInstance(
          clientId: const String.fromEnvironment("REDDIT_CLIENT_ID"),
          userAgent: userAgent,
          redirectUri: Uri.parse(
              const String.fromEnvironment("REDDIT_REDIRECT_URI")
          )
      );

      authUrl = reddit.auth.url(["*"], userAgent, compactLogin: true);
    }
    else {
      reddit = Reddit.restoreInstalledAuthenticatedInstance(token,
          clientId: const String.fromEnvironment("REDDIT_CLIENT_ID"),
          userAgent: userAgent,
          redirectUri: Uri.parse(
              const String.fromEnvironment("REDDIT_REDIRECT_URI")
          )
      );
    }
  }

  bool get isConnected =>
    me != null;
}