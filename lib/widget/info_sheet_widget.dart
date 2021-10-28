import 'package:app/extensions/subroddit.dart';
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../roddit_colors.dart';

class InfoSheetWidget extends StatelessWidget {
  final Subreddit sub;

  const InfoSheetWidget({Key? key, required this.sub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (context, controller) {
              return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16)
                      )
                  ),
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: RodditColors.pink,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)
                                ),
                                image: (sub.mobileHeaderImage
                                    ?.hasAbsolutePath == true)
                                    ? DecorationImage(
                                    image: NetworkImage(
                                        sub.mobileHeaderImage!.toString()),
                                    fit: BoxFit.cover
                                )
                                    : (sub.headerImage?.hasAbsolutePath == true)
                                    ? DecorationImage(
                                    image: NetworkImage(
                                        sub.headerImage!.toString()),
                                    fit: BoxFit.cover) : null,
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(0, 60, 0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 60,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: (sub.iconImage
                                      ?.hasAbsolutePath == true)
                                      ? NetworkImage(sub.iconImage!.toString())
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Column(
                                  children: [
                                    Text(sub.title, style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                                  ]
                              ), flex: 3),
                              Expanded(child: Column(), flex: 3),
                              Expanded(child:
                              Column(
                                children: [
                                  Text("/r/" + sub.displayName),
                                ],
                              ), flex: 3)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(sub.publicDescription),
                        ),
                        const Divider(indent: 24, endIndent: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(sub.subscribers.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)
                                ),
                                const Text("subscribers"),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Created on"),
                                Text(DateFormat.yMMMd().format(sub.created),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(indent: 24, endIndent: 24),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: MarkdownBody(data: sub.description),
                        )
                      ]
                  )
              );
            })
    );
  }
}