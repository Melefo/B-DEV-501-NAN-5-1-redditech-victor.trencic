import 'package:app/controllers/Controller.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/wrapper/RedditPost.dart';
import 'package:app/wrapper/RedditWrapper.dart';
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
  List<RedditPost> posts = [];

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          drawer: NavigationDrawerWidget(),
          appBar: NavigationTopBarWidget(title: "Home"),
          bottomNavigationBar: NavigationBotBarWidget(),
          floatingActionButton: NavigationFabButtonWidget(buttonIcon: Icons.cached),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: StreamBuilder<List<RedditPost>>(
          stream: RedditWrapper.getFrontHots(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              posts = [...posts, ...snapshot.data!];
            return ListView.separated(padding: EdgeInsets.all(20.0),
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    trailing: posts[index].thumbnail != null ? Image.network(posts[index].thumbnail!, width: 50, height: 50, fit: BoxFit.cover) : null,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Text("${posts[index].author} in ${posts[index].subreddit}"),
                        new Text(posts[index].upvotes.toString())
                      ],
                    ),
                    subtitle: Text(posts[index].description),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: Divider(indent: 100, endIndent: 20),
                  );
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: posts.length);
          },
        ),
      );
}