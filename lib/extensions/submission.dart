import 'package:app/models/reddit_gallery.dart';
import 'package:draw/draw.dart';

extension RodditSubmission on Submission {
  String? get description => "";

  bool get isGallery => data!['is_gallery'] ?? false;

  List<GalleryData> get gallery {
    List<GalleryData> list = [];

    if (data!["gallery_data"]?["items"] != null) {
      for (var elem in data!["gallery_data"]!["items"]!) {
        list.add(GalleryData(elem));
      }
    }
    return list;
  }
}