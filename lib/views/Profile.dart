import 'package:app/RodditColors.dart';
import 'package:app/controllers/Controller.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class Profile extends StatefulWidget {
  final String title;

  const Profile({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<Profile> createState() => _Profile();
}

//state
class _Profile extends StateMVC<Profile> {
  final Controller controller = Controller();

  @override

  Widget build(BuildContext context) =>
      Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(icon: Icon(
                  Icons.filter_list_rounded,
                  color: Colors.white),
                  onPressed: () {}
              ),
              Spacer(),
              IconButton(icon: Icon(Icons.settings, color: Colors.white), onPressed: () {}),
            ],
          ),
          shape: CircularNotchedRectangle(),
          color: RodditColors.pink,
        ),

        floatingActionButton:
        FloatingActionButton(child: Icon(Icons.cached), onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}