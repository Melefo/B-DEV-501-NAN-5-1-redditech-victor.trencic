import 'package:app/controllers/reddit_offline.dart';
import 'package:app/roddit_colors.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

import 'nav_filter_widget.dart';

class NavigationBotBarWidget extends StatelessWidget {
  final Function(OfflineGetType) callback;

  const NavigationBotBarWidget({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          NavigationFilterWidget(callback: callback),
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