import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/widget/settings_button_widget.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class Settings extends StatefulWidget {
  final String title;

  const Settings({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<Settings> createState() => _Settings();
}

//state
class _Settings extends StateMVC<Settings> {
  final RedditClient client = RedditClient();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: const NavigationTopBarWidget(title: "Settings"),
        bottomNavigationBar: NavigationBotBarWidget(),
        floatingActionButton: NavigationFabButtonWidget(buttonIcon: Icons.home, onPressed: () => Navigator.pushNamed(context, "/")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SettingsButtonWidget()

      );
}