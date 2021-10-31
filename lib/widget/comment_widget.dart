import 'package:app/extensions/comment.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../roddit_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:math' as math;

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final bool showSubmission;

  const CommentWidget(
      {Key? key, required this.comment, this.showSubmission = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white
      ),
      child: Column(
        children: [
          if (showSubmission)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                  color: RodditColors.pink.shade50
              ),
              child: Row(
                children: [
                  Text.rich(TextSpan(
                      children: <TextSpan>[
                        const TextSpan(text: "On "),
                        TextSpan(
                            text: comment.submissionTitle!,
                            style: const TextStyle(color: Colors.black)
                        ),
                        const TextSpan(text: " from "),
                        TextSpan(
                            text: comment.submissionAuthor!,
                            style: TextStyle(color: RodditColors.pink
                            )
                        ),
                        const TextSpan(text: " in "),
                        TextSpan(
                            text: comment.subredditName!,
                            style: TextStyle(color: RodditColors.blue
                            )
                        )
                      ],
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45
                      )
                  )),

                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(comment.author,
                          style: TextStyle(
                              color: RodditColors.blue,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: Icon(MdiIcons.triangleOutline,
                            size: 14,
                            color: RodditColors.pink,
                          ),
                        ),
                      ),
                      Text(timeago.format(comment.createdUtc),
                          style: const TextStyle(
                              color: Colors.black45
                          )
                      )
                    ],
                  ),
                ),
                Text(comment.body!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}