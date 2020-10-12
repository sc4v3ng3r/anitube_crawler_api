import 'package:anitube_crawler_api/src/domain/entities/Item.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/entities/HomePageInfo.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:anitube_crawler_api/src/domain/entities/AnimeItem.dart';
import 'package:anitube_crawler_api/src/domain/entities/EpisodeItem.dart';

enum _HomePageAnimeCategory { MOST_SHOWED, MOST_RECENT, DAY_RELEASE }

class AnitubeHomePageParser implements IHTMLParser<HomePageInfo> {
  AnitubeHomePageParser();

  @override
  HomePageInfo parseHTML(String html) {
    if (html == null)
      throw ParserException(message: "AnitubeHomePageParser HTML is null");

    final latestEpisodes = _extractLatestEpisodes(html);
    final mostShowedAnimes = _extractMostShowedAnimes(html);
    final recentAnimes = _extractRecentAnimes(html);
    final dailyReselases = _extractDayRelease(html);

    return HomePageInfo(
      recentAnimes.map((e) => AnimeItem.fromJson(e)).toList(),
      mostShowedAnimes.map((e) => AnimeItem.fromJson(e)).toList(),
      latestEpisodes.map((e) => EpisodeItem.fromJson(e)).toList(),
      dailyReselases.map((e) => AnimeItem.fromJson(e)).toList(),
    );
  }

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
            .getElementsByClassName(_HomePageHtmlNames.ANI_ITEM);

        aniItemList.forEach((aniItem) {
          try {
            dataList.add(_parseItem(aniItem, _HomePageHtmlNames.ANI_ITEM_IMG,
                _HomePageHtmlNames.ANI_CC));
          } on ParserException catch (ex) {
            print('HomePageParser::_parseAnimeItemContent ${ex.message}');
          }
        });
      } catch (ex) {
        print(
            'HomePageParser::_parseAnimeItemContent error while parsing.\n$ex');
        throw ParserException(message: "Error parsing Animes");
      }
    }

    return dataList;
  }

  /// Obtem os epsodios mais recentes
  List<Map<String, dynamic>> _extractLatestEpisodes(String page) {
    var dataList = <Map<String, dynamic>>[];
    var body = parse(page).getElementsByTagName('body')[0];
    // container class changes
    var subContainer = body
        .getElementsByClassName(_HomePageHtmlNames.EPI_CONTAINER)[0]
        .getElementsByClassName(_HomePageHtmlNames.EPI_SUBCONTAINER)[0];

    subContainer.children.forEach((epiItem) {
      try {
        dataList.add(_parseItem(epiItem, _HomePageHtmlNames.EPI_ITEM_IMG,
            _HomePageHtmlNames.EPI_CC));
      } on ParserException catch (ex) {
        print('HomePageParser::extractLatestEpisodes ${ex.message} ');
      }
    });

    return dataList;
  }

  /// Obtem os animes mais visualizados
  List<Map<String, dynamic>> _extractMostShowedAnimes(String page) =>
      _parseAnimeItemContent(page,
          category: _HomePageAnimeCategory.MOST_SHOWED);

  /// obtem os animes mais recentes
  List<Map<String, dynamic>> _extractRecentAnimes(String page) =>
      _parseAnimeItemContent(page,
          category: _HomePageAnimeCategory.MOST_RECENT);

  /// Obtem lancamentos do dia
  List<Map<String, dynamic>> _extractDayRelease(String page) =>
      _parseAnimeItemContent(page,
          category: _HomePageAnimeCategory.DAY_RELEASE);

  Map<String, dynamic> _parseItem(Element itemElement, String divImageClassName,
      String closedCaptionClassName) {
    var pageLink;
    var title;
    var id;
    var imageUrl;
    var cc;

    try {
      pageLink = itemElement.children[0].attributes['href'];
      title = itemElement.children[0].attributes['title'];
      id = pageLink.split('.site/')[1];

      id = id.substring(0, id.length - 1);

      var itemImgDiv = itemElement.children[0]
          //divImageClassName
          .getElementsByClassName(divImageClassName)[0];

      imageUrl = itemImgDiv.getElementsByTagName('img')[0].attributes['src'];

      /// closedCaptionClassName
      var elementList =
          itemImgDiv.getElementsByClassName(closedCaptionClassName);

      cc = (elementList == null || elementList.isEmpty)
          ? "Legendado"
          : elementList[0].text;

      return {
        Item.ID: id,
        Item.TITLE: title,
        Item.PAGE_URL: pageLink,
        Item.IMAGE_URL: imageUrl,
        Item.CC: cc,
      };
    } catch (ex) {
      print("ItemParser::parseItem error parsing item.\n $ex");
      print('PageLink: $pageLink\n'
          'ID: $id\n'
          'title: $title\n'
          'imageUrl: $imageUrl\n'
          'CC: $cc');

      throw ParserException(message: "Error parsing item");
    }
  }
}

class _HomePageHtmlNames {
  static const ANI_CONTAINER = "aniContainer"; // class
  static const MAIN_CAROUSEL = "main-carousel"; // class
  static const FLICK_SLIDER = "flickity-slider"; // class
  static const FLICKITY_VIEWPORT = "flickity-viewport"; // class

  static const EPI_CONTAINER = "epiContainer";
  static const EPI_SUBCONTAINER = "epiSubContainer";
  static const ANI_ITEM = "aniItem"; // class
  static const ANI_ITEM_IMG = "aniItemImg";
  static const EPI_ITEM_IMG = "epiItemImg";
  static const ANI_CC = "aniCC";
  static const EPI_CC = "epiCC";
}
