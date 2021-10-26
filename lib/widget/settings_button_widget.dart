import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
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
  bool _is_over_18 = false;
  bool _is_hidden = false;
  bool _is_beta = false;
  bool _night_mode = false;
  bool _email_chat_r = false;
  bool _email_comment_r = false;

  @override
  Widget build(BuildContext context) {
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
                    value: _night_mode,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value)  {
                      setState(() {
                        _night_mode = value;
                        // fonction à appeler avec value en param
                      });
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
                    value: _is_beta,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value)  {
                      setState(() {
                        _is_beta = value;
                        // fonction à appeler avec value en param
                      });
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
                  value: _is_over_18,
                  activeColor: Color(0xFF6200EE),
                  inactiveThumbColor: Color(0x33333333),
                  onChanged: (bool value)  {
                    setState(() {
                      _is_over_18 = value;
                      // fonction à appeler avec value en param
                    });
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
                    value: _is_hidden,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value)  {
                      setState(() {
                        _is_hidden = value;
                        // fonction à appeler avec value en param
                      });
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
                    value: _email_chat_r,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value)  {
                      setState(() {
                        _email_chat_r = value;
                        // fonction à appeler avec value en param
                      });
                    },
                  ),
                ]
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Email Comment reply'),
                  Switch(
                    value: _email_comment_r,
                    activeColor: Color(0xFF6200EE),
                    inactiveThumbColor: Color(0x33333333),
                    onChanged: (bool value)  {
                      setState(() {
                        _email_comment_r = value;
                        // fonction à appeler avec value en param
                      });
                    },
                  ),
                ]
            ),
          ]
        )
      ]
    );

  }
}
