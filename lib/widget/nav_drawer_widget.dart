import 'package:app/controllers/reddit_client.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final redditClient = RedditClient();

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    if (redditClient.isConnected) {
    }
    else {
      list.add(OutlinedButton(
          onPressed: () => redditClient.connect(context),
          child: const Text("CONNECT")
      ));
    }
      return Drawer(
        child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: const Text("accountName"),
              accountEmail: const Text("accountEmail"),
              currentAccountPicture: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      "/profile"
                  );
                },
                child: const CircleAvatar(child: Text("P")),
              )
          ),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, "/");
              },
          ), ...list
        ],
      ),);
  }
}