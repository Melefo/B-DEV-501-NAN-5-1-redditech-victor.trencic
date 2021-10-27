import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../roddit_colors.dart';

class NavigationFilterWidget extends StatefulWidget {
  const NavigationFilterWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationFilterWidget();
}

class _NavigationFilterWidget extends State<NavigationFilterWidget> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PopupMenuButton(
          color: RodditColors.pink,
          icon: const Icon(
          Icons.filter_list_rounded,
          color: Colors.white),
          initialValue: _value,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row (children: [Icon(Icons.local_fire_department, color: Colors.red), Text("Hot", style: TextStyle(color: Colors.white,),)]),
              value: 1,
            ),
            PopupMenuItem(
              child: Row (children: [Icon(Icons.verified_outlined, color: Colors.lightGreen), Text("New", style: TextStyle(color: Colors.white,),)]),
              value: 2,
            ),
            PopupMenuItem(
              child: Row (children: [Icon(Icons.moving_rounded, color: Colors.deepPurple), Text("Rising", style: TextStyle(color: Colors.white,),)]),
              value: 3,
            ),
            PopupMenuItem(
              child: Row (children: [Icon(Icons.bar_chart_rounded, color: Colors.tealAccent), Text("Top", style: TextStyle(color: Colors.white,),)]),
              value: 4,
            ),
            PopupMenuItem(
              child: Row (children: [Icon(Icons.flash_on_rounded, color: Colors.amber), Text("Controversial", style: TextStyle(color: Colors.white,),)]),
              value: 5,
            ),
          ],
          onSelected: (int newValue) {
            setState(() {
              _value = newValue;
              ///sortMainFeed();
            });
          },
        )
      ]
    );
  }
}