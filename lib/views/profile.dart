import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
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
  final RedditClient client = RedditClient();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (client.isConnected) {
      children.add(Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 50),
          child: CircleAvatar(
              child: Image.network(client.me!.iconImg!),
              radius: 75),
        ),
        decoration: BoxDecoration(image: DecorationImage(
            image: NetworkImage(client.me!.bannerImg!),
            fit: BoxFit.cover
        )
        ),
      )
      );
      children.add(Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                  client.me!.displayName,
                  style: const TextStyle(fontSize: 40)
              )
          )
      ));
      children.add(Padding(
          padding: const EdgeInsets.only(
              left: 42, right: 42, top: 300, bottom: 16),
          child: Text(
              client.me!.description!, style: const TextStyle(fontSize: 16))
      ));
      children.add(const Divider(indent: 32, endIndent: 32));
      children.add(Text(client.me.toString()));
    }

    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: const NavigationTopBarWidget(title: "Profile"),
      bottomNavigationBar: const NavigationBotBarWidget(),
      floatingActionButton: NavigationFabButtonWidget(
          buttonIcon: Icons.home,
          onPressed: () => Navigator.pushNamed(context, "/")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: RodditColors.pink,
                  image: DecorationImage(
                      image: NetworkImage(client.me!.bannerImg!),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                transform: Matrix4.translationValues(0, -30, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(client.me!.iconImg!),
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 24, bottom: 10),
                              child: Text(client.me!.username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32
                                  ))
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("/u/" + client.me!.displayName,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black45
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(client.me!.description ?? ""),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Divider(indent: 16, endIndent: 16),
                      )
                    ]
                )
            ),
          ]
      ),
    );
  }
}