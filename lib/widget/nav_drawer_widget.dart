import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/roddit_colors.dart';
import 'package:draw/draw.dart';
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
  final client = RedditClient();
  final List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    if (client.isConnected) {
      /*client.me!.subreddits.listen((event) {
        setState(() {
          list.add(ListTile(title: Text(event.title)));
        });
      });*/
    }
    else {
      list.add(OutlinedButton(
          onPressed: () => client.connect(context),
          child: const Text("CONNECT")
      ));
    }
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
                client.isConnected
                    ? client.me!.username
                    : "Roddit"
            ),
            accountEmail: Text(
                client.isConnected ? client.me!.fullname ?? "" : ""
            ),
            currentAccountPicture: TextButton(
              onPressed: () {
                if (!client.isConnected) {
                  return;
                }
                Navigator.pushNamed(
                    context,
                    "/profile"
                );
              },
              child: CircleAvatar(
                  child: client.isConnected ? Image.network(
                      client.me!.iconImg!) : const Text("P"),
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0)
              ),
            ),
            decoration: BoxDecoration(
                image: client.isConnected ? DecorationImage(
                    image: NetworkImage(client.me!.bannerImg!),
                    fit: BoxFit.cover) : null,
                color: RodditColors.pink
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ), ...list,
          StreamBuilder(
            stream: client.me?.subreddits,
            builder: (builder, snapshot) {
              if (snapshot.hasData) {
                  //list.add(new ListTile(title: Text(snapshot.data!)));
              }
              return Column(children: list);
            }
          )
        ],
      ));
  }
}