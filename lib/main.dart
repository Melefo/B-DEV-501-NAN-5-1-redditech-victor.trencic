import 'package:app/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart'
    show AppMVC;

void main() =>
  runApp(Roddit());

class Roddit extends AppMVC
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roddit",
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: Home(title: "Roddit")
    );
  }
}