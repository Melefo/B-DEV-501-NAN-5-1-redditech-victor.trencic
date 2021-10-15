import 'package:app/views/Home.dart';
import 'package:app/views/Settings.dart';
import 'package:app/views/Profile.dart';
import 'package:app/wrapper/RedditWrapper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart'
    show AppMVC;
import 'RodditColors.dart';

void main() =>
  runApp(Roddit());

class Roddit extends AppMVC
{
  @override
  Widget build(BuildContext context) {
    RedditWrapper.getFrontHots();
    return MaterialApp(
      title: "Roddit",
      theme: ThemeData(
        primarySwatch: RodditColors.pink,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: RodditColors.blue
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(title: "Roddit"),
        '/settings': (context) => const Settings(title: "Settings"),
        '/profile': (context) => const Profile(title: "Profile")
      }
    );
  }
}