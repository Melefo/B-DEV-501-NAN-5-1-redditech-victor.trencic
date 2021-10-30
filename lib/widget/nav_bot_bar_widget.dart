import 'package:app/roddit_colors.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

import 'nev_filter_widget.dart';

class NavigationBotBarWidget extends StatelessWidget {

  const NavigationBotBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          NavigationFilterWidget(),
          const Spacer(),
          IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () {
            Navigator.pushNamed(context, "/settings");
          }),
        ]
      ),
      shape: const CircularNotchedRectangle(),
      color: RodditColors.pink,
    );
  }
}