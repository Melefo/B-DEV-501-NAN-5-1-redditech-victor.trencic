import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/widget/submission_widget.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

import 'home.dart';

//view
class ProfileView extends StatefulWidget {
  final String title;

  static String routeName = "/profile";

  const ProfileView({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<ProfileView> createState() => _Profile();
}

//state
class _Profile extends StateMVC<ProfileView> {
  final RedditClient client = RedditClient();
  final List<Widget> texts = [];

  @override
  void initState() {
    super.initState();
    if (!client.isConnected) {
      return;
    }
    client.me!.submissions.newest().listen((event) async {
      var submission = event as Submission;
      setState(() {
        texts.add(SubmissionWidget(data: submission));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: NavigationTopBarWidget(title: widget.title),
      bottomNavigationBar: const NavigationBotBarWidget(),
      floatingActionButton: NavigationFabButtonWidget(
          buttonIcon: Icons.home,
          onPressed: () => Navigator.pushNamed(context, HomeView.routeName)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
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
            ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return texts[index];
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    child: Divider(indent: 100, endIndent: 20),
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: texts.length
            )
          ]
      ),
    );
  }
}