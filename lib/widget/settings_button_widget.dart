import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:app/widget/row_button_widget.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class SettingsButtonWidget extends StatefulWidget {
  const SettingsButtonWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsButtonWidget();
}

class _SettingsButtonWidget extends State<SettingsButtonWidget> {
  final RedditClient client = RedditClient();
  RedditPrefs? prefs;

  @override
  void initState() {
    super.initState();
    client.me!.prefs.then((value) =>
    {
      setState(() {
        prefs = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      return ListView();
    }
    return ListView(
        children: [
          Column(children: [
            RowButtonWidget(
                textContent: 'Night Mode',
                field: 'nightmode',
                prefs: prefs!,
                category: "Enable Night Mode in preferences"
            ),
            RowButtonWidget(
                textContent: 'Status Online',
                field: 'show_presence',
                prefs: prefs!,
                category: "Status"
            ),
            RowButtonWidget(
                textContent: 'Enable the Beta view interface',
                field: 'beta',
                prefs: prefs!,
                category: "Beta Interface"
            ),
            RowButtonWidget(
                textContent: 'Allow +18 content (NSFW)',
                field: 'label_nsfw',
                prefs: prefs!,
                category: "NSFW content"
            ),
            RowButtonWidget(
                textContent: 'Over 18',
                field: 'over_18',
                prefs: prefs!
            ),
            RowButtonWidget(
                textContent: 'Search include Over 18',
                field: 'search_include_over_18',
                prefs: prefs!
            ),
            RowButtonWidget(
                textContent: 'Show your profil in search result',
                field: 'show_presence',
                prefs: prefs!,
                category: "Hide from search"
            ),
            RowButtonWidget(
                textContent: 'Email Comment reply',
                field: 'nightmode',
                prefs: prefs!,
                category: "Email"
            ),
          ]
          )
        ]
    );
  }
}