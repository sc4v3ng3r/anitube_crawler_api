// part of anitube_crawler_api;

/// This is the base class for AnimeItem and EpisodeItem implementation.
/// actually both classes are equals to Item class only the name is different
/// to be more legible.
abstract class Item {
  /// The item id
  final String id;

  /// item page url
  final String pageUrl;

  /// Item cover image url
  final String imageUrl;

  /// Item title
  final String title;

  /// Item closed caption type.
  final String closeCaptionType;

  static const ID = "id";
  static const PAGE_URL = "pageUrl";
  static const IMAGE_URL = "imageUrl";
  static const TITLE = "title";
  static const CC = "closeCaption";

  Item.fromJson(Map<String, dynamic> json)
      : id = json[ID],
        pageUrl = json[PAGE_URL],
        imageUrl = json[IMAGE_URL],
        title = json[TITLE],
        closeCaptionType = json[CC];

  @override
  String toString() {
    return "$ID: $id\n$TITLE: $title\n$IMAGE_URL: $imageUrl\n"
        "$PAGE_URL: $pageUrl\n"
        "$CC: $closeCaptionType";
  }
}
