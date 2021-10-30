import 'package:app/roddit_colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final Submission submission;

  const Post({Key? key, required this.submission}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      trailing: submission.thumbnail.hasAbsolutePath ? Image.network(
          submission.thumbnail.toString()) : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: submission.author,
                      style: TextStyle(
                          color: RodditColors.pink,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  const TextSpan(
                      text: " in "
                  ),
                  TextSpan(
                      text: submission.subreddit.displayName,
                      style: TextStyle(
                          color: RodditColors.blue,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ],
                style: const TextStyle(fontSize: 14)
            ),
          ),
          Text(
            submission.upvotes.toString(),
            style: const TextStyle(
                color: Colors.black45
            ),
          )
        ],
      ),
      subtitle: Text(
        submission.title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}