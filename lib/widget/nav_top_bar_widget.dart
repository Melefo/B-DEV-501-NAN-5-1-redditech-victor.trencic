import 'dart:core';
import 'package:app/arguments/sub_args.dart';
import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:app/views/subreddit.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class NavigationTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final RedditClient client = RedditClient();
  late RedditPrefs prefs;
  late bool over_18 = false;

  NavigationTopBarWidget({Key? key, required this.title}) : super(key: key)
  {
    if (client.isConnected) {
      client.me!.prefs.then((value) {
        prefs = value;
        over_18 = prefs.over18;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(icon: const Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: ExSearch(client: client, over_18: over_18));
          }),
        ),
      ]
    );
  }
  @override
  
  Size get preferredSize => const Size.fromHeight(50);
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({Key? key, required this.onInit, required this.child})
      : super(key: key);

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ExSearch extends SearchDelegate<String> {
  final RedditClient client;
  final bool over_18;
  late Future<List<SubredditRef>> subsTab = getSubs();

  ExSearch({required this.client, required this.over_18});

  Future<List<SubredditRef>> getSubs() async {
    List<SubredditRef> subs = await client.getSubsFromName(query, over_18);
    return subs;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }


  @override
  Widget buildSuggestions(BuildContext context) =>
      FutureBuilder<List<SubredditRef>>(
          future: getSubs(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SubredditRef>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final ref = snapshot.data![index];
                  final suggestion = ref.displayName;

                  return FutureBuilder(
                    future: ref.populate(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Subreddit> snapshot) {
                      return ListTile(
                        onTap: () async {
                          Navigator.pushNamed(context, SubredditView.routeName,
                              arguments: SubredditArguments(
                                  sub: await ref.populate()));
                        },
                        title: Text("/r/" + suggestion),
                        leading: snapshot.hasData ?
                        CircleAvatar(
                          backgroundImage: snapshot.data!.iconImage
                              ?.hasAbsolutePath ?? false
                              ? NetworkImage(snapshot.data!.iconImage
                              .toString())
                              : null,
                        ) : null,
                      );
                    },
                  );
                },
              );
            } else {
              return Container();
            }
          }
      );
}