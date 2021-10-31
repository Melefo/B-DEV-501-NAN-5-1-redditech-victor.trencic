import 'package:draw/draw.dart';

extension RodditComment on Comment {
  String? get submissionTitle => data!["link_title"];

  String? get submissionAuthor => data!["link_author"];

  String? get subredditName => data!["subreddit"];
}