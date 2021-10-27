import 'package:app/models/reddit_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../roddit_colors.dart';

class PostWidget extends StatelessWidget {
  RedditPost post;

  PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      trailing: post.thumbnail != null ? Image.network(
          post.thumbnail!,
          width: 50,
          height: 50,
          fit: BoxFit.cover
      ) : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                    text: post.author,
                    style: TextStyle(
                        color: RodditColors.pink,
                        fontWeight: FontWeight.bold)
                ),
                const TextSpan(text: " in "),
                TextSpan(
                    text: post.subreddit,
                    style: TextStyle(
                        color: RodditColors.blue,
                        fontWeight: FontWeight.bold)
                )
              ]
              ),
              style: const TextStyle(fontSize: 14)
          ),
          Text(post.upvotes.toString(),
              style: const TextStyle(color: Colors.black45)
          )
        ],
      ),
      subtitle: Text(post.description,
          style: const TextStyle(color: Colors.black)
      ),
    );
  }

}