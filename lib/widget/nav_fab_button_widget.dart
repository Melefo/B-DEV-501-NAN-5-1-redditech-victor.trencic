import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationFabButtonWidget extends StatelessWidget {

  final IconData buttonIcon;
  final VoidCallback? onPressed;

  const NavigationFabButtonWidget(
      {Key? key, required this.buttonIcon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(child: Icon(buttonIcon), onPressed: onPressed);
  }
}