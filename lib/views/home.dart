import 'dart:async';
import 'package:app/controllers/reddit_client.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/models/reddit_post.dart';
import 'package:app/controllers/reddit_offline.dart';
import 'package:app/widget/post_widget.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class HomeView extends StatefulWidget {
  final String title;

  static String routeName = "/";

  const HomeView({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<HomeView> createState() => _Home();
}

//state
class _Home extends StateMVC<HomeView> {
  final RedditClient client = RedditClient();
  final RedditOffline offline = RedditOffline();
  final ScrollController _controller = ScrollController();
  final List<RedditPost> posts = [];
  PostType currentType = PostType.hot;
  StreamSubscription _stream = const Stream.empty().listen((event) {});
  bool _end = false;

  void emptyPosts() {
    if (client.isConnected) {
      client.resetPosts(currentType);
    }
    else {
      offline.resetPosts(currentType);
    }
    setState(() => posts.clear());
    listen();
  }

  void listen() {
    _end = false;
    _stream.cancel();
    if (client.isConnected) {
      _stream = client.getFrontPosts(currentType).listen((event) {
        setState(() {
          posts.add(event);
        });
      }, onDone: () {
        _end = true;
      });
    }
    else {
      _stream = offline.getPosts(currentType).listen((event) {
        setState(() {
          posts.add(event);
        });
      }, onDone: () {
    _end = true;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    listen();
    _controller.addListener(() {
      if (_controller.position.outOfRange && _controller.position.pixels > 0 &&
          _end) {
        listen();
      }
    });
  }

  void filter(PostType newType) {
    currentType = newType;
    emptyPosts();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          drawer: NavigationDrawerWidget(callback: emptyPosts),
          appBar: NavigationTopBarWidget(title: widget.title),
          bottomNavigationBar: NavigationBotBarWidget(callback: filter),
          floatingActionButton: NavigationFabButtonWidget(
              buttonIcon: Icons.cached,
              onPressed: emptyPosts
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
          body: ListView.separated(
            padding: const EdgeInsets.all(20.0),
            itemBuilder: (context, index) {
              return PostWidget(post: posts[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                child: Divider(indent: 100, endIndent: 20),
              );
            },
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: posts.length,
            controller: _controller,
          )
      );
}