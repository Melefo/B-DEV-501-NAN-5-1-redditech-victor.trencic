import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryWidget extends StatefulWidget {
  final List<String> links;

  const GalleryWidget({Key? key, required this.links}) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidget();
}

class _GalleryWidget extends State<GalleryWidget> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.links.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Image> widgets = [];
    for (var link in widget.links) {
      widgets.add(Image.network(link.replaceAll("amp;", "")));
    }

    return TabBarView(
      children: widgets,
      controller: _tabController,
    );
  }
}