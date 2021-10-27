import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/roddit_colors.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key? key, this.callback}) : super(key: key);

  Function()? callback;

  @override
  State<StatefulWidget> createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final client = RedditClient();
  final List<Widget> list = [];

  @override
  void initState() {
    super.initState();
    if (!client.isConnected) {
      list.add(OutlinedButton(
          onPressed: () {
            client.connect(context).then((value) {
              if (widget.callback != null) {
                widget.callback!();
              }
            });
          },
          child: const Text("CONNECT")
      ));
    }
    else {
      client.me!.subreddits.listen((sub) async {
        setState(() {
          list.add(ListTile(
            leading: CircleAvatar(
              backgroundImage: sub.iconImage?.hasAbsolutePath ?? false
                  ? NetworkImage(sub.iconImage.toString())
                  : null,
            ),
            title: Text(sub.title),
          ));
        });
      });
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
            ListView(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                      child: Icon(Icons.home)
                  ),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                ), ...list
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