import 'package:app/controllers/reddit_client.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../roddit_colors.dart';

class NavigationFilterWidget extends StatefulWidget {
  final Function(PostType)? callback;

  const NavigationFilterWidget({Key? key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationFilterWidget();
}

class _NavigationFilterWidget extends State<NavigationFilterWidget> {
  PostType _value = PostType.hot;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PopupMenuButton<PostType>(
            color: RodditColors.pink,
            icon: const Icon(
                Icons.filter_list_rounded,
                color: Colors.white),
            initialValue: _value,
            itemBuilder: (context) =>
            [
              PopupMenuItem(
                child: Row(children: const [
                  Icon(Icons.local_fire_department, color: Colors.red),
                  Text("Hot", style: TextStyle(color: Colors.white,))
                ]),
                value: PostType.hot,
              ),
              PopupMenuItem(
                child: Row(children: const [
                  Icon(Icons.verified_outlined, color: Colors.lightGreen),
                  Text("New", style: TextStyle(color: Colors.white,))
                ]),
                value: PostType.newest,
              ),
              PopupMenuItem(
                child: Row(children: const [
                  Icon(Icons.moving_rounded, color: Colors.deepPurple),
                  Text("Rising", style: TextStyle(color: Colors.white,))
                ]),
                value: PostType.rising,
              ),
              PopupMenuItem(
                child: Row(children: const [
                  Icon(Icons.bar_chart_rounded, color: Colors.tealAccent),
                  Text("Top", style: TextStyle(color: Colors.white,))
                ]),
                value: PostType.top,
              ),
              PopupMenuItem(
                child: Row(children: const [
                  Icon(Icons.flash_on_rounded, color: Colors.amber),
                  Text("Controversial", style: TextStyle(color: Colors.white,))
                ]),
                value: PostType.controversial,
              ),
            ],
            onSelected: (PostType newValue) {
              setState(() {
                if (_value == newValue) {
                  return;
                }
                _value = newValue;
                if (widget.callback != null) {
                  widget.callback!(newValue);
                }
              });
            },
          )
        ]
    );
  }
}