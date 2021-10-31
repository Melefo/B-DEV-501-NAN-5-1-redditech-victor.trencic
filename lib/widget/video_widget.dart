import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String link;

  const VideoWidget({Key? key, required this.link}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidget();
}

class _VideoWidget extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.link)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) =>
      AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: TextButton(
              onPressed: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              },
              child: VideoPlayer(_controller)
          )
      );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}