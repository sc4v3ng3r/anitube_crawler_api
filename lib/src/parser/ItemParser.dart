// part of anitube_crawler_api;

class ItemParser {
  // static const ANI_ITEM = "aniItem"; // class
  // static const ANI_ITEM_IMG = "aniItemImg";
  // static const EPI_ITEM_IMG = "epiItemImg";
  // static const ANI_CC = "aniCC";
  // static const EPI_CC = "epiCC";

  // static Map<String, dynamic> parseItem(Element itemElement,
  //     String divImageClassName, String closedCaptionClassName) {

  //   var pageLink;
  //   var title;
  //   var id;
  //   var imageUrl;
  //   var cc;

  //   try {
  //     pageLink = itemElement.children[0].attributes['href'];
  //     title = itemElement.children[0].attributes['title'];
  //     id = pageLink.split('.site/')[1];

  //     id = id.substring(0, id.length - 1);

  //     var itemImgDiv = itemElement.children[0]
  //         //divImageClassName
  //         .getElementsByClassName(divImageClassName)[0];

  //     imageUrl =
  //         itemImgDiv.getElementsByTagName('img')[0].attributes['src'];

  //     /// closedCaptionClassName
  //     var elementList = itemImgDiv.getElementsByClassName(closedCaptionClassName);

  //     cc = (elementList == null || elementList.isEmpty) ? "Legendado" : elementList[0].text;

  //     return {
  //       Item.ID: id,
  //       Item.TITLE: title,
  //       Item.PAGE_URL: pageLink,
  //       Item.IMAGE_URL: imageUrl,
  //       Item.CC: cc,
  //     };
  //   }

  //   catch (ex) {
  //     print("ItemParser::parseItem error parsing item.\n $ex");
  //     print('PageLink: $pageLink\n'
  //         'ID: $id\n'
  //         'title: $title\n'
  //         'imageUrl: $imageUrl\n'
  //         'CC: $cc'
  //     );

  //     throw ParserException(message: "Error parsing item");
  //   }

  // }
}
