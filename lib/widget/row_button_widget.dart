import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:app/roddit_colors.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class RowButtonWidget extends StatefulWidget {
  RowButtonWidget({this.category = null, Key? key, required this.prefs, required this.field, required this.textContent}) : super(key: key);
  String field;
  RedditPrefs prefs;
  String textContent;
  String? category;

  @override
  State<StatefulWidget> createState() => _RowButtonWidget();
}

class _RowButtonWidget extends State<RowButtonWidget> {
  final RedditClient client = RedditClient();

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          if (widget.category != null)
            Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text(widget.category!)),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(widget.textContent),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Switch(
                  value: widget.prefs.data[widget.field],
                  activeColor: RodditColors.pink,
                  inactiveThumbColor: RodditColors.blue,
                  onChanged: (bool value) async {
                    setState(() {
                      widget.prefs.data[widget.field] = value;
                    });
                    await client.savePrefs(widget.prefs);
                  },
                ),
              ),
            ],
          ),
        ]
    );
  }
}