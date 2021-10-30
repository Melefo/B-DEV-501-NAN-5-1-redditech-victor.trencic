class RedditPost {
  late String subreddit;
  late String author;
  late String description;
  late int upvotes;
  late String? thumbnail;
  late String id;

  RedditPost(
      {required this.id, required this.subreddit, required this.author, required this.description, required this.upvotes, required this.thumbnail});

  RedditPost.fromJson(Map<String, dynamic> json) {
    id = json["name"];
    subreddit = json["subreddit"];
    author = json["author"];
    description = json["title"];
    upvotes = json["ups"];
    thumbnail = json["thumbnail"];
    if (Uri.tryParse(thumbnail!)?.hasAbsolutePath == false) {
      thumbnail = null;
    }
  }
}