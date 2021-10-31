import 'package:app/controllers/reddit_client.dart';
import 'package:app/models/reddit_data.dart';
import 'package:app/views/home.dart';
import 'package:app/views/settings.dart';
import 'package:app/views/profile.dart';
import 'package:app/views/subreddit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mvc_application/view.dart'
    show AppMVC;
import 'roddit_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await Roddit.storage.read(key: RedditData.tokenKey);
  await RedditClient.init(token: token);
  runApp(Roddit());
}

class Roddit extends AppMVC {
  Roddit({Key? key}) : super(key: key);

  static const FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
          debugShowCheckedModeBanner: kReleaseMode,
          title: "Roddit",
          theme: ThemeData(
              primarySwatch: RodditColors.pink,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: RodditColors.blue
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    primary: RodditColors.blue,
                  )
              )
          ),
          initialRoute: HomeView.routeName,
          routes: {
            HomeView.routeName: (context) => const HomeView(title: "Roddit"),
            SettingsView.routeName: (context) =>
            const SettingsView(title: "Settings"),
            ProfileView.routeName: (context) =>
            const ProfileView(title: "Profile"),
            SubredditView.routeName: (context) => const SubredditView()
          }
      );
}