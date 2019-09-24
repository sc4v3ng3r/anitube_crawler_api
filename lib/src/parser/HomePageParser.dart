part of anitube_crawler_api;

enum _HomePageAnimeCategory { MOST_SHOWED, MOST_RECENT, DAY_RELEASE }

class HomePageParser {
  List<Map<String, dynamic>> _parseAnimeItemContent(String page,
      {_HomePageAnimeCategory category = _HomePageAnimeCategory.MOST_SHOWED}) {
    var dataList = <Map<String, dynamic>>[];
    Document pageDocument;

    if (page != null || page.isNotEmpty) {
      try {
              pageDocument = parse(page);
      var body = pageDocument.getElementsByTagName('body')[0];
      var containers =
          body.getElementsByClassName(_HomePageHtmlNames.ANI_CONTAINER);

      // most recents aniItems
      var aniItemList = containers[category.index]
          .children[1]
          .getElementsByClassName(ItemParser.ANI_ITEM);

      aniItemList.forEach((aniItem) {
        dataList.add(ItemParser.parseItem(
            aniItem, ItemParser.ANI_ITEM_IMG, ItemParser.ANI_CC));
      });

      } 
      catch (ex){
        print('HomePageParser::_parseAnimeItemContent error while parsing.\n$ex');
        throw ParserException(message: "Error parsing Animes");
      } 
    }

    return dataList;
  }

  /// Obtem os epsodios mais recentes
  List<Map<String, dynamic>> extractLatestEpisodes(String page) {
    var dataList = <Map<String, dynamic>>[];
    var body = parse(page).getElementsByTagName('body')[0];

    // container class changes
    var subContainer = body
        .getElementsByClassName(_HomePageHtmlNames.EPI_CONTAINER)[0]
        .getElementsByClassName(_HomePageHtmlNames.EPI_SUBCONTAINER)[0];

    subContainer.children.forEach((epiItem) {
      dataList.add(ItemParser.parseItem(
          epiItem, ItemParser.EPI_ITEM_IMG, ItemParser.EPI_CC));
    });

    return dataList;
  }

  /// Obtem os animes mais visualizados
  List<Map<String, dynamic>> extractMostShowedAnimes(String page) =>
      _parseAnimeItemContent(page,
          category: _HomePageAnimeCategory.MOST_SHOWED);

  /// obtem os animes mais recentes
  List<Map<String, dynamic>> extractRecentAnimes(String page) =>
      _parseAnimeItemContent(page,
          category: _HomePageAnimeCategory.MOST_RECENT);

  /// Obtem lancamentos do dia
  List<Map<String, dynamic>> extractDayRelease(String page) =>
      _parseAnimeItemContent(page,
          category: _HomePageAnimeCategory.DAY_RELEASE);
}

class _HomePageHtmlNames {
  static const ANI_CONTAINER = "aniContainer"; // class
  static const MAIN_CAROUSEL = "main-carousel"; // class
  static const FLICK_SLIDER = "flickity-slider"; // class
  static const FLICKITY_VIEWPORT = "flickity-viewport"; // class

  static const EPI_CONTAINER = "epiContainer";
  static const EPI_SUBCONTAINER = "epiSubContainer";
}
