import 'package:app/roddit_colors.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmissionWidget extends StatelessWidget {
  final Submission data;

  const SubmissionWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      trailing: data.thumbnail.hasAbsolutePath ? Image.network(
          data.thumbnail.toString()) : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: data.author,
                      style: TextStyle(
                          color: RodditColors.pink,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  const TextSpan(
                      text: " in "
                  ),
                  TextSpan(
                      text: data.subreddit.displayName,
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
            data.upvotes.toString(),
            style: const TextStyle(
                color: Colors.black45
            ),
          )
        ],
      ),
      subtitle: Text(
        data.title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}