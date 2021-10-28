import 'package:app/controllers/reddit_client.dart';
import 'package:app/controllers/reddit_offline.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/views/settings.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

import 'nav_filter_widget.dart';

class NavigationBotBarWidget extends StatelessWidget {
  RedditClient client = RedditClient();
  final Function(PostType)? callback;

  NavigationBotBarWidget({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          NavigationFilterWidget(callback: callback),
          const Spacer(),

          if (client.isConnected)
          IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () {
            Navigator.pushNamed(context, SettingsView.routeName);
          }),
        ],
      ),
      shape: const CircularNotchedRectangle(),
      color: RodditColors.pink,
    );
  }
}