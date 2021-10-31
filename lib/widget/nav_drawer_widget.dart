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
  const NavigationDrawerWidget({Key? key, this.callback, this.sub}) : super(key: key);

  final Function()? callback;
  final String? sub;

  @override
  State<StatefulWidget> createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final client = RedditClient();
  final List<Widget> list = [];
  late bool _disposed = false;

  String get currentRoute =>
      ModalRoute
          .of(context)!
          .settings
          .name!;

  void listen() {
    client.me!.subreddits().listen((sub) async {
      if (_disposed) {
        return;
      }
      setState(() {
        list.add(ListTile(
          leading: CircleAvatar(
            backgroundImage: sub.iconImage?.hasAbsolutePath ?? false
                ? NetworkImage(sub.iconImage.toString())
                : null,
          ),
          title: Text("/r/" + sub.displayName,
              style: TextStyle(
                  color: widget.sub != sub.fullname
                      ? RodditColors.blue
                      : RodditColors.pink
              )
          ),
          onTap: () {
            if (widget.sub != sub.fullname) {
              Navigator.pushReplacementNamed(context, SubredditView.routeName,
                  arguments: SubredditArguments(sub: sub));
            }
            else {
              Navigator.pop(context);
            }
          },
          selected: widget.sub == sub.fullname,
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
                      : "Anonymous Rodditor"
              ),
              accountEmail: Text(
                  client.isConnected
                      ? "/u/" + client.me!.displayName
                      : "Not connected"
              ),
              currentAccountPicture: TextButton(
                onPressed: () {
                  if (!client.isConnected) {
                    return;
                  }
                  if (currentRoute != ProfileView.routeName) {
                    Navigator.pushReplacementNamed(
                      context,
                      ProfileView.routeName
                  );
                  }
                  else {
                    Navigator.pop(context);
                  }
                },
                child: CircleAvatar(
                  backgroundImage: (
                      client.isConnected ?
                      NetworkImage(client.me!.iconImg!) :
                      const AssetImage("assets/icon/icon.png")
                  ) as ImageProvider,
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
                  leading: CircleAvatar(
                    child: Icon(Icons.home,
                      size: 38,
                      color: currentRoute == HomeView.routeName ?
                      RodditColors.pink : RodditColors.blue,
                    ),
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                  ),
                  title: Text("Home",
                      style: TextStyle(
                        color: currentRoute == HomeView.routeName ?
                        RodditColors.pink : RodditColors.blue,
                      )
                  ),
                  onTap: () {
                    if (currentRoute != HomeView.routeName) {
                      Navigator.pushReplacementNamed(
                          context, HomeView.routeName);
                    }
                    else {
                      Navigator.pop(context);
                    }
                  },
                  selected: currentRoute == HomeView.routeName,
                ),
                if (!client.isConnected)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 82),
                    child: OutlinedButton(
                        onPressed: () async {
                          await client.connect();
                          if (client.isConnected && widget.callback != null) {
                            listen();
                            widget.callback!();
                          }
                        },
                        child: const Text("CONNECT")
                    ),
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