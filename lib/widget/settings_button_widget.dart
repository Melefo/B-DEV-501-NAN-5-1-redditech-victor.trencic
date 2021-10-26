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
  bool _is_over_18 = true;
  bool _is_hidden = false;

  @override
  Widget build(BuildContext context) {
    return ListView (
      children: [
        Column (children: [
            Row(
              children: const <Widget>[
                Padding(padding: EdgeInsets.all(16.0),child: Text("Profile Picture")),
                Expanded(
                    child: Divider()
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB( 50, 0, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                      child: client.isConnected ? Image.network(
                          client.me!.iconImg!) : const Text("P"),
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0)
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text("MODIFY"),
                  )
                ]
              ),
            ),
            Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("Banner")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB( 50, 20, 50, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  client.me?.bannerImg != null ?
                  Image.network(
                    client.me!.bannerImg!,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 150) :
                  Image.asset(
                      'assets/default_image.png',
                      fit: BoxFit.fill,
                      height: 100,
                      width: 150),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text("MODIFY"),
                  ),
                ]
              ),
            ),

            Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.all(16.0),child: Text("Display Name")),
                  Expanded(
                      child: Divider()
                  ),
                ]
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                initialValue: '',
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Your name here',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  isDense: true,
                )
              ),
            ),

          Row(
              children: const <Widget>[
                Padding(padding: EdgeInsets.all(16.0),child: Text("Biography")),
                Expanded(
                    child: Divider()
                ),
              ]
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: TextFormField (
                initialValue: '',
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: '200 characters maximum',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  isDense: true,
                )
            ),
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
            )
          ]
        )
      ]
    );

  }
}
