import 'package:app/controllers/Controller.dart';
import 'package:app/widget/nav_drawer_widget.dart';
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
          appBar: AppBar(
              title: Text(widget.title),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
                ),
              ],
              //backgroundColor: Colors.purple,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.filter_list_rounded), onPressed: () {}),
                Spacer(),
                IconButton(icon: Icon(Icons.settings), onPressed: () {}),
              ],
            ),
            shape: CircularNotchedRectangle(),
          ),

          floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}