import 'package:app/views/Home.dart';
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
    return MaterialApp(
      title: "Roddit",
      theme: ThemeData(
        primarySwatch: RodditColors.pink,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: RodditColors.blue
        )
      ),
      home: Home(title: "Roddit")
    );
  }
}