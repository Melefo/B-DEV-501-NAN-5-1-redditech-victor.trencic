import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/rodditor.dart';
import 'package:app/models/reddit_prefs.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/widget/comment_widget.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/widget/post_widget.dart';
import 'package:draw/draw.dart';
import 'package:intl/intl.dart';
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
class _Profile extends StateMVC<ProfileView> with SingleTickerProviderStateMixin {
  final RedditClient client = RedditClient();
  final List<Widget> posts = [];
  final List<Widget> comments = [];
  final List<Widget> upvotes = [];
  final List<Widget> downvotes = [];
  late int totalKarma = (client.me!.awardeeKarma ?? 0) +
      (client.me!.awarderKarma ?? 0) + (client.me!.commentKarma ?? 0) +
      (client.me!.linkKarma ?? 0);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    if (!client.isConnected) {
      return;
    }
    client.me!.submissions.newest().listen((event) async {
      var submission = event as Submission;
      setState(() {
        posts.add(PostWidget(post: submission));
      });
    });
    client.me!.comments.newest().listen((event) async {
      var comment = event as Comment;
      setState(() {
        comments.add(CommentWidget(comment: comment, showSubmission: true));
      });
    });
    client.me!.upvoted().listen((event) async {
      var submission = event as Submission;
      setState(() {
        upvotes.add(PostWidget(post: submission));
      });
    });
    client.me!.downvoted().listen((event) async {
      var submission = event as Submission;
      setState(() {
        downvotes.add(PostWidget(post: submission));
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: NavigationTopBarWidget(title: widget.title),
        bottomNavigationBar: const NavigationBotBarWidget(),
        floatingActionButton: NavigationFabButtonWidget(
            buttonIcon: Icons.home,
            onPressed: () => Navigator.pushNamed(context, HomeView.routeName)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    pinned: true,
                    expandedHeight: 427,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: RodditColors.pink,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                client.me!.bannerImg!),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 50,
                                            child: CircleAvatar(
                                              radius: 45,
                                              backgroundImage: NetworkImage(
                                                  client.me!
                                                      .iconImg!),
                                            ),
                                          ),
                                          flex: 2
                                      ),
                                      Expanded(
                                          child: Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 18,
                                                  vertical: 6
                                              ),
                                              child: Text(client.me!.username,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 32
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                          ),
                                          flex: 8),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "/u/" + client.me!.displayName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black45
                                                )
                                            ),
                                          ),
                                          FutureBuilder(
                                            future: client.me!.prefs,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                    RedditPrefs> snapshot) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    height: 12,
                                                    width: 12,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: snapshot
                                                            .hasData &&
                                                            snapshot.data!
                                                                .showPresence
                                                            ? Colors.lightGreen
                                                            : Colors.redAccent
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(left: 8.0),
                                                    child: Text(
                                                        snapshot.hasData &&
                                                            snapshot.data!
                                                                .showPresence
                                                            ? "Online"
                                                            : "Offline",
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black12
                                                        )
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0),
                                        child: Text(client.me!.description ??
                                            ""),
                                      )
                                    ]
                                )
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Divider(indent: 16, endIndent: 16),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Karma"),
                                      Text("$totalKarma",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Birthday"),
                                      Text(DateFormat.yMMMd().format(
                                          client.me!.createdUtc!),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Gold"),
                                      Text("${client.me!.goldCreddits ?? 0}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)
                                      )
                                    ],
                                  )
                                ]
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Divider(indent: 16, endIndent: 16),
                            )
                          ]
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                          unselectedLabelColor: Colors.black,
                          tabs: const [
                            Tab(text: "Posts"),
                            Tab(text: "Comments"),
                            Tab(text: "Upvotes"),
                            Tab(text: "Downvotes"),
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: RodditColors.blue,
                        ),
                      ),
                    )
                )
              ];
            },
            body: TabBarView(
              children: [
                if (posts.isNotEmpty)
                  ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return posts[index];
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          child: Divider(indent: 100, endIndent: 20),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: posts.length
                  )
                else
                  const Center(child: Text('No posts')),
                if (comments.isNotEmpty)
                  ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return comments[index];
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          child: Divider(indent: 100, endIndent: 20),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: comments.length
                  )
                else
                  const Center(child: Text('No comments')),
                if (upvotes.isNotEmpty)
                  ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return upvotes[index];
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          child: Divider(indent: 100, endIndent: 20),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: upvotes.length
                  )
                else
                  const Center(child: Text('No upvotes')),
                if (downvotes.isNotEmpty)
                  ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return downvotes[index];
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          child: Divider(indent: 100, endIndent: 20),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: downvotes.length
                  )
                else
                  const Center(child: Text('No downvotes'))
              ],
              controller: _tabController,
            )
        ),
      );
}