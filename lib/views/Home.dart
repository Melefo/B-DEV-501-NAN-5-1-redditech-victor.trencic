import 'package:app/RodditColors.dart';
import 'package:app/controllers/Controller.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<Home> createState() => _Home();
}

//state
class _Home extends StateMVC<Home> {
  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          drawer: NavigationDrawerWidget(),
          appBar: NavigationTopBarWidget(title: "Home"),
          bottomNavigationBar: NavigationBotBarWidget(),
          floatingActionButton: NavigationFabButtonWidget(buttonIcon: Icons.cached),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}