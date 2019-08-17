part of anitube_crawler_api;

abstract class Item {
  final String id;
  final String pageUrl;
  final String imageUrl;
  final String title;
  final String closeCaptionType;

  static const ID = "id";
  static const PAGE_URL = "pageUrl";
  static const IMAGE_URL= "imageUrl";
  static const TITLE = "title";
  static const CC = "closeCaption";

  Item.fromJson( Map<String, dynamic> json) :
        id = json[ID],
        pageUrl = json[PAGE_URL],
        imageUrl = json[IMAGE_URL],
        title = json[TITLE],
        closeCaptionType = json[CC];

  @override
  String toString() {
    return
      "$ID: $id\n$TITLE: $title\n$IMAGE_URL: $imageUrl\n"
          "$PAGE_URL: $pageUrl\n"
          "$CC: $closeCaptionType";
  }
}