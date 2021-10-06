import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

void main() =>
  runApp(const Redditech());

class Redditech extends StatelessWidget {
  const Redditech({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redditech',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(title: 'Redditech'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  var _reddit = Reddit.createInstalledFlowInstance(
    clientId: "bHR1qe1C3cUY5pKQLpH2nA",
    userAgent: "Redditech",
    redirectUri: Uri.parse("reddit://callback")
  );
  Uri? _authUrl;
  Redditor? _user;

  void _incrementCounter() =>
    setState(() =>
      _counter++
    );

  void _auth() async
  {
    setState(() => _authUrl ??= _reddit.auth.url(["*"], "Redditech", compactLogin: true));
    var auth = await FlutterWebAuth.authenticate(url: _authUrl.toString(), callbackUrlScheme: "reddit");
    String? code = Uri.parse(auth).queryParameters["code"];
    await _reddit.auth.authorize(code.toString());
    var user = await _reddit.user.me();
    setState(() => _user = user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times: $_counter',
            ),
            Text((() {
              if (_user == null)
                return "You must be connected";
              return _user.toString();
            }())),
            TextButton(
                onPressed: _auth,
                child: Text("Connect to Reddit"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
