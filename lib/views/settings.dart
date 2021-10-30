import 'package:app/controllers/reddit_client.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/widget/settings_button_widget.dart';
import 'package:flutter/services.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

import 'home.dart';

//view
class SettingsView extends StatefulWidget {
  final String title;

  static String routeName = "/settings";

  const SettingsView({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<SettingsView> createState() => _Settings();
}

//state
class _Settings extends StateMVC<SettingsView> {
  final RedditClient client = RedditClient();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: NavigationTopBarWidget(title: widget.title),
        bottomNavigationBar: const NavigationBotBarWidget(),
        floatingActionButton: NavigationFabButtonWidget(buttonIcon: Icons.home, onPressed: () => Navigator.pushNamed(context, HomeView.routeName)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: const SettingsButtonWidget()

      );
}