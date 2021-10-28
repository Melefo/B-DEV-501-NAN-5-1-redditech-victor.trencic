import 'package:draw/draw.dart';

extension Subroddit on Subreddit {
  bool get isSubscribed => data!["user_is_subscriber"];
  set isSubscribed(bool value) {
    data!["user_is_subscriber"] = value;
  }

  String get publicDescription => data!["public_description"];

  String get description => data!["description"];

  int get subscribers => data!["subscribers"];

  DateTime get created => DateTime.fromMillisecondsSinceEpoch(data!["created_utc"].round() * 1000, isUtc: true);
}