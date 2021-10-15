import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  NavigationTopBarWidget({required this.title}) {
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ),
      ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}