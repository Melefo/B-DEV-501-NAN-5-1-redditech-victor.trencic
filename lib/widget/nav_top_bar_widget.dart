import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NavigationTopBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ),
      ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}