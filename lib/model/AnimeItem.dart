part of anitube_crawler_api;

class AnimeItem {

  final String id;
  final String pageUrl;
  final String imageUrl;
  final String title;
  final String closeCaptionType;

  static final ID = "id";
  static final PAGE_URL = "pageUrl";
  static final IMAGE_URL= "imageUrl";
  static final TITLE = "title";
  static final CC = "closeCaption";

  AnimeItem.fromJson(Map<String, dynamic> json) :
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