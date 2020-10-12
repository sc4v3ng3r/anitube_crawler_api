import 'package:anitube_crawler_api/src/domain/entities/Item.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/entities/HomePageInfo.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_elements_name.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_item_parser_utils.dart';
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
            body.getElementsByClassName(AnitubeElementName.ANI_CONTAINER);

        // most recents aniItems
        var aniItemList = containers[category.index]
            .children[1]
            .getElementsByClassName(AnitubeElementName.ANI_ITEM);

        aniItemList.forEach((aniItem) {
          try {
            dataList.add(parseItem(aniItem, AnitubeElementName.ANI_ITEM_IMG,
                AnitubeElementName.ANI_CC));
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
        .getElementsByClassName(AnitubeElementName.EPI_CONTAINER)[0]
        .getElementsByClassName(AnitubeElementName.EPI_SUBCONTAINER)[0];

    subContainer.children.forEach((epiItem) {
      try {
        dataList.add(parseItem(epiItem, AnitubeElementName.EPI_ITEM_IMG,
            AnitubeElementName.EPI_CC));
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
}
