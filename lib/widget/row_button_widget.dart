import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:app/roddit_colors.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class RowButtonWidget extends StatefulWidget {
  RowButtonWidget({Key? key, required this.prefs, required this.field, required this.textContent}) : super(key: key);
  String field;
  RedditPrefs prefs;
  String textContent;

  @override
  State<StatefulWidget> createState() => _RowButtonWidget();
}

class _RowButtonWidget extends State<RowButtonWidget> {
  final RedditClient client = RedditClient();

  @override
  Widget build(BuildContext context) {
    return Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.textContent),
          Switch(
            value: widget.prefs.data[widget.field],
            activeColor: RodditColors.blue,
            inactiveThumbColor: RodditColors.pink,
            onChanged: (bool value) async {
              setState(() {
                widget.prefs.data[widget.field] = value;
              });
              await client.savePrefs(widget.prefs);
            },
          ),
        ]
    );
  }
}