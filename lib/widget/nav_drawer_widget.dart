import 'package:app/arguments/sub_args.dart';
import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/views/home.dart';
import 'package:app/views/profile.dart';
import 'package:app/views/subreddit.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key, this.callback}) : super(key: key);

  final Function()? callback;

  @override
  State<StatefulWidget> createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final client = RedditClient();
  final List<Widget> list = [];

  void listen() {
    client.me!.subreddits.listen((sub) async {
      setState(() {
        list.add(ListTile(
          leading: CircleAvatar(
            backgroundImage: sub.iconImage?.hasAbsolutePath ?? false
                ? NetworkImage(sub.iconImage.toString())
                : null,
          ),
          title: Text("/r/" + sub.displayName),
          onTap: () {
            Navigator.pushNamed(context, SubredditView.routeName,
                arguments: SubredditArguments(sub: sub));
          },
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (client.isConnected) {
      listen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                  client.isConnected
                      ? client.me!.username
                      : "Roddit"
              ),
              accountEmail: Text(
                  client.isConnected ? "/u/" + client.me!.displayName : ""
              ),
              currentAccountPicture: TextButton(
                onPressed: () {
                  if (!client.isConnected) {
                    return;
                  }
                  Navigator.pushNamed(
                      context,
                      ProfileView.routeName
                  );
                },
                child: CircleAvatar(
                  backgroundImage: client.isConnected ?
                  NetworkImage(client.me!.iconImg!) : null,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                  radius: 32,
                ),
              ),
              decoration: BoxDecoration(
                  image: client.isConnected ? DecorationImage(
                      image: NetworkImage(client.me!.bannerImg!),
                      fit: BoxFit.cover) : null,
                  color: RodditColors.pink
              ),
            ),
            ListView(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                      child: Icon(Icons.home)
                  ),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pushNamed(context, HomeView.routeName);
                  },
                ),
                if (!client.isConnected)
                  OutlinedButton(
                      onPressed: () async {
                        await client.connect();
                        if (client.isConnected && widget.callback != null) {
                          listen();
                          widget.callback!();
                        }
                      },
                      child: const Text("CONNECT")
                  )
                ,
                ...list
              ],
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
            )
          ],
        )
    );
  }
}