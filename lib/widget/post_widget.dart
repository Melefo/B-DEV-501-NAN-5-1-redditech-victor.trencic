import 'package:app/extensions/submission.dart';
import 'package:app/widget/gallery_widget.dart';
import 'package:app/widget/video_widget.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../roddit_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatelessWidget {
  final Submission post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text.rich(
                        TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: post.author,
                              style: TextStyle(
                                  color: RodditColors.pink,
                                  fontWeight: FontWeight.bold)
                          ),
                          const TextSpan(text: " in "),
                          TextSpan(
                              text: post.subreddit.displayName,
                              style: TextStyle(
                                  color: RodditColors.blue,
                                  fontWeight: FontWeight.bold)
                          )
                        ]
                        ),
                        style: const TextStyle(fontSize: 14)
                    ),
                  ),
                  Text(post.title,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(post.upvotes.toString(),
                    style: const TextStyle(color: Colors.black45),
                  ),
                  if (post.thumbnail.hasAbsolutePath == true)
                    IconButton(
                        iconSize: 50,
                        onPressed: () async {
                          if (post.isVideo) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Dialog(
                                        backgroundColor: const Color.fromRGBO(
                                            0, 0, 0, 0),
                                        child: VideoWidget(link: post
                                            .data!["media"]["reddit_video"]["hls_url"])
                                    )
                            );
                          }
                          else if (RegExp(r".(gif|jpe?g|bmp|png)$").hasMatch(
                              post.url.toString())) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Dialog(
                                      backgroundColor: const Color.fromRGBO(
                                          0, 0, 0, 0),
                                      child: Image.network(post.url.toString()),
                                    )
                            );
                          }
                          else if (post.isGallery) {
                            List<String> links = [];
                            for (var elem in post.gallery) {
                              links.add(post.data!["media_metadata"][elem
                                  .mediaId]["s"]["u"]);
                            }
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    Dialog(
                                        backgroundColor: const Color.fromRGBO(
                                            0, 0, 0, 0),
                                        child: GalleryWidget(links: links)
                                    )
                            );
                          }
                          else {
                            _launchURL(post.url.toString());
                          }
                        },
                        icon: Image.network(
                            post.thumbnail.toString(),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover
                        )
                    )
                ],
              )
          ),
        ],
      ),
    );
  }
}