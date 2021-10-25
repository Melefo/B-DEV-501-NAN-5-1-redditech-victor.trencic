import 'package:app/controllers/reddit_client.dart';
import 'package:app/models/rodditor.dart';
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
              accountName: Text(
                redditClient.isConnected ? redditClient.me!.displayName : "Roddit"
              ),
              accountEmail: Text(
                  redditClient.isConnected ? redditClient.me!.fullname ?? "" : ""
              ),
              currentAccountPicture: TextButton(
                onPressed: () {
                  if (!redditClient.isConnected) {
                    return;
                  }
                  Navigator.pushNamed(
                      context,
                      "/profile"
                  );
                },
                child: CircleAvatar(child: redditClient.isConnected ? Image.network(redditClient.me!.iconImg!) : Text("P")),
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