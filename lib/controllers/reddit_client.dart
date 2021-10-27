import 'dart:convert';
import 'package:app/models/reddit_data.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class RedditClient extends ControllerMVC {
  factory RedditClient() => _this ??= RedditClient._();

  static RedditClient? _this;
  late RedditData _model;

  RedditClient._() {
    _model = RedditData();
  }

  bool get isConnected => _model.isConnected;

  Redditor? get me => _model.me;

  Future<void> connect(BuildContext context) async {
    try {
      var auth = await FlutterWebAuth.authenticate(
          url: _model.authUrl.toString(),
          callbackUrlScheme: _model.userAgent.toLowerCase());
      String? code = Uri
          .parse(auth)
          .queryParameters["code"];
      await _model.reddit.auth.authorize(code.toString());
      _model.me = await _model.reddit.user.me();
      Navigator.pop(context);
    }
    catch (_) {
      _model = RedditData();
      Navigator.pop(context);
      return;
    }

  }

  Future<void> savePrefs(RedditPrefs prefs) async {
    var res = await http.patch(Uri.https("oauth.reddit.com", "api/v1/me/prefs"),
        headers: {
          "Authorization": "Bearer ${_model.reddit.auth.credentials
              .accessToken}",
          "Content-Type": "application/json"
        }, body: json.encode(prefs.data));
    if (res.statusCode != 200) {
      throw DRAWAuthenticationError("Can't save user prefs");
    }
  }
}