import 'package:app/RodditColors.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationBotBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
        IconButton(icon: Icon(
          Icons.filter_list_rounded,
          color: Colors.white),
          onPressed: () {}
        ),
        Spacer(),
        IconButton(icon: Icon(Icons.settings, color: Colors.white), onPressed: () {
          Navigator.pushNamed(context, "/settings");
        }),
      ],
      ),
      shape: CircularNotchedRectangle(),
      color: RodditColors.pink,
    );
  }
}