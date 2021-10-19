import 'package:app/models/reddit_data.dart';
import 'package:flutter/services.dart';
import 'package:mvc_application/controller.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class RedditClient extends ControllerMVC {
  factory RedditClient() => _this ??= RedditClient._();

  static RedditClient? _this;
  late RedditData _model;

  RedditClient._()
  {
    _model = RedditData();
  }

  bool get isConnected => _model.isConnected;

  Future<void> connect(BuildContext context) async {
    try {
      var auth = await FlutterWebAuth.authenticate(
          url: _model.authUrl.toString(),
          callbackUrlScheme: _model.userAgent.toLowerCase());
      String? code = Uri.parse(auth).queryParameters["code"];
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
}