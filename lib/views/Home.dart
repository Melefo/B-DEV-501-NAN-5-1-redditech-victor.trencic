import 'package:app/controllers/Controller.dart';
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

          appBar: AppBar(
              title: Text(widget.title),
              leading: Icon(Icons.menu),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
                ),
              ],
              //backgroundColor: Colors.purple,
          ),

          drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: Text("accountName"),
                    accountEmail: Text("accountEmail"),
                    currentAccountPicture: CircleAvatar(child: Text("P"))
                ),

                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home") //Faire un Boutton
                )
              ],
            ),
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