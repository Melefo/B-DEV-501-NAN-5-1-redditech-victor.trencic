import 'package:draw/draw.dart';

class Model {
  late Reddit reddit;
  late Uri authUrl;
  String userAgent = const String.fromEnvironment("REDDIT_USER_AGENT");

  Model() {
    reddit = Reddit.createInstalledFlowInstance(
        clientId: const String.fromEnvironment("REDDIT_CLIENT_ID"),
        userAgent: userAgent,
        redirectUri: Uri.parse(const String.fromEnvironment("REDDIT_REDIRECT_URI"))
    );

    authUrl = reddit.auth.url(["*"], userAgent, compactLogin: false);
  }
}