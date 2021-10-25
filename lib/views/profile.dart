import 'package:app/controllers/reddit_client.dart';
import 'package:app/models/rodditor.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class Profile extends StatefulWidget {
  final String title;

  const Profile({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<Profile> createState() => _Profile();
}

//state
class _Profile extends StateMVC<Profile> {
  @override
  final RedditClient client = RedditClient();

  @override

  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (client.isConnected) {
      children.add(Image.network(client.me!.iconImg!));
      children.add(Text(client.me!.displayName));
      children.add(Text(client.me!.description!));
    }

    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: const NavigationTopBarWidget(title: "Profile"),
        bottomNavigationBar: const NavigationBotBarWidget(),
        floatingActionButton: const NavigationFabButtonWidget(buttonIcon: Icons.home),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ListView(children: children)
      );
  }
}