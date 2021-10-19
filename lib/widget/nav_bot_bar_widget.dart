import 'package:app/roddit_colors.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationBotBarWidget extends StatelessWidget {

  const NavigationBotBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
        IconButton(icon: const Icon(
          Icons.filter_list_rounded,
          color: Colors.white),
          onPressed: () {}
        ),
          const Spacer(),
        IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () {
          Navigator.pushNamed(context, "/settings");
        }),
      ],
      ),
      shape: const CircularNotchedRectangle(),
      color: RodditColors.pink,
    );
  }
}