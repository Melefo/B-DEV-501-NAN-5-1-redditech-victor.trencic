import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      "/profile");
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
          )
        ],
      ),);
  }
}