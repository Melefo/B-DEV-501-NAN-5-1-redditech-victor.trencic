import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../roddit_colors.dart';

class PostWidget extends StatelessWidget {
  final Submission post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

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
                  if (post.thumbnail.hasAbsolutePath == true) Image.network(
                      post.thumbnail.toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover
                  )
                ],
              )),
        ],
      ),
    );
  }
}