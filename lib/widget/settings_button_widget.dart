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
    if (prefs == null)
      return ListView();
    return ListView (
      children: [
        Column (children: [
            Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("Night Mode")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Enable Night Mode in preferences'),
                  Switch(
                    value: prefs!.nightmode,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value) async {
                      setState(() {
                        prefs!.nightmode = value;
                      });
                      await client.savePrefs(prefs!);
                    },
                  ),
                ]
            ),
            Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("Beta interface")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Enable the Beta view interface'),
                  Switch(
                    value: prefs!.beta,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value) async {
                      setState(() {
                        prefs!.beta = value;
                      });
                      await client.savePrefs(prefs!);
                    },
                  ),
                ]
            ),
            Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("NSFW content")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Allow +18 content (NSFW)'),
                Switch(
                  value: prefs!.over18,
                  activeColor: Color(0xFF6200EE),
                  inactiveThumbColor: Color(0x33333333),
                  onChanged: (bool value) async {
                    setState(() {
                      prefs!.over18 = value;
                    });
                    await client.savePrefs(prefs!);
                  },
                ),
              ]
            ),
            Row (
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("Hide from search")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show your profil in search result'),
                  Switch(
                    value: prefs!.research,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value) async {
                      setState(() {
                        prefs!.research = value;
                      });
                      await client.savePrefs(prefs!);
                    },
                  ),
                ]
            ),
            Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("Email")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Email Chat request'),
                  Switch(
                    value: prefs!.emailChatRequest,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value) async {
                      setState(() {
                        prefs!.emailChatRequest = value;
                      });
                      await client.savePrefs(prefs!);
                    },
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Email Comment reply'),
                  Switch(
                    value: prefs!.emailCommentReply,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value)  async {
                      setState(() {
                        prefs!.emailCommentReply = value;
                      });
                      await client.savePrefs(prefs!);
                    },
                  ),
                ]
            ),
            RowButtonWidget(textContent: 'showGoldExpiration', field: 'showGoldExpiration', prefs: prefs!),
          ]
        )
      ]
    );

  }
}
