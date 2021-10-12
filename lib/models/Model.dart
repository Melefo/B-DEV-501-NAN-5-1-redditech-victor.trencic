import 'package:draw/draw.dart';

class Model {
  late Reddit reddit;
  late Uri authUrl;
  String userAgent = String.fromEnvironment("REDDIT_USER_AGENT");

  Model() {
    reddit = Reddit.createInstalledFlowInstance(
        clientId: String.fromEnvironment("REDDIT_CLIENT_ID"),
        userAgent: userAgent,
        redirectUri: Uri.parse(String.fromEnvironment("REDDIT_REDIRECT_URI"))
    );

    authUrl = reddit.auth.url(["*"], userAgent, compactLogin: false);
  }
}