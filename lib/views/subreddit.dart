import 'dart:async';
import 'package:app/arguments/sub_args.dart';
import 'package:app/controllers/reddit_client.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/widget/post_widget.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class SubredditView extends StatefulWidget {
  static String routeName = "/sub";

  const SubredditView({Key? key}) : super(key: key);

  @override
  StateMVC<SubredditView> createState() => _Subreddit();
}

//state
class _Subreddit extends StateMVC<SubredditView> {
  bool first = false;
  final RedditClient client = RedditClient();
  final ScrollController _controller = ScrollController();
  final List<Submission> posts = [];
  PostType currentType = PostType.hot;
  StreamSubscription _stream = const Stream.empty().listen((event) {});
  bool _end = false;
  Subreddit? sub;

  void emptyPosts() {
    client.resetSubPosts(sub!.displayName, currentType);
    setState(() {
      posts.clear();
    });
    listen();
  }

  void listen() {
    _end = false;
    _stream.cancel();
    if (sub != null) {
      _stream =
          client.getSubPosts(sub!.displayName, currentType).listen((event) {
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
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SubredditArguments;
    sub = args.sub;
    if (!first) {
      emptyPosts();
      first = true;
    }

    return Scaffold(
          drawer: NavigationDrawerWidget(callback: emptyPosts, sub: sub!.fullname),
          appBar: NavigationTopBarWidget(title: sub!.title),
          bottomNavigationBar: NavigationBotBarWidget(callback: filter, sub: sub),
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
}