class GalleryData {
  String get mediaId => data["media_id"];

  int get id => data["id"];

  String? get caption => data["caption"];

  final Map<String, dynamic> data;

  GalleryData(this.data);
}
