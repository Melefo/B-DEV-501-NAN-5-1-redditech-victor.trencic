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
      /*children.add(Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 25),
          child: CircleAvatar(
            child: Image.network(client.me!.iconImg!),
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            radius: 125,
          )
      ));*/
      children.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 25),
          child: CircleAvatar(
              child: Image.network(client.me!.iconImg!),
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
              radius: 150),
        ),
        decoration: BoxDecoration(image: DecorationImage(
            image: NetworkImage(client.me!.bannerImg!),
            fit: BoxFit.cover
        )
        ),
      )
      );
      children.add(Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                client.me!.displayName,
                style: const TextStyle(fontSize: 40)
              )
          )
      ));
      children.add(Padding(
          padding: const EdgeInsets.only(
              left: 42, right: 42, top: 300, bottom: 16),
          child: Text(
              client.me!.description!, style: const TextStyle(fontSize: 16))
      ));
      children.add(const Divider(indent: 32, endIndent: 32));
    }

    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: const NavigationTopBarWidget(title: "Profile"),
        bottomNavigationBar: const NavigationBotBarWidget(),
        floatingActionButton: NavigationFabButtonWidget(
            buttonIcon: Icons.home,
            onPressed: () => Navigator.pushNamed(context, "/")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ListView(children: children)
    );
  }
}