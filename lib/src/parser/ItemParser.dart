part of anitube_crawler_api;

class ItemParser {
  static const ANI_ITEM = "aniItem"; // class
  static const ANI_ITEM_IMG = "aniItemImg";
  static const EPI_ITEM_IMG = "epiItemImg";
  static const ANI_CC = "aniCC";
  static const EPI_CC = "epiCC";

  static Map<String, dynamic> parseItem(Element itemElement,
      String divImageClassName, String closedCaptionClassName) {
    try {
      var pageLink = itemElement.children[0].attributes['href'];
      var title = itemElement.children[0].attributes['title'];
      var id = pageLink.split('.site/')[1];

      id = id.substring(0, id.length - 1);

      var itemImgDiv = itemElement.children[0]
          //divImageClassName
          .getElementsByClassName(divImageClassName)[0];

      var imageUrl =
          itemImgDiv.getElementsByTagName('img')[0].attributes['src'];

      /// closedCaptionClassName
      var cc =
          itemImgDiv.getElementsByClassName(closedCaptionClassName)[0].text;

      return {
        Item.ID: id,
        Item.TITLE: title,
        Item.PAGE_URL: pageLink,
        Item.IMAGE_URL: imageUrl,
        Item.CC: cc,
      };
    }

    catch (ex) {
      print("ItemParser::parseItem error parsing item.\n $ex");
      throw ParserException(message: "Error parsing item");
    }

  }
}
