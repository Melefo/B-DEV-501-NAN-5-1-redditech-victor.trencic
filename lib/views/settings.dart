import 'package:app/controllers/reddit_client.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
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
  @override
  final RedditClient controller = RedditClient();

  @override

  Widget build(BuildContext context) =>
      const Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: NavigationTopBarWidget(title: "Settings"),
        bottomNavigationBar: NavigationBotBarWidget(),
        floatingActionButton: NavigationFabButtonWidget(buttonIcon: Icons.home),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}