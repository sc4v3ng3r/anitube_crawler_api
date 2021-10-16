import 'package:html/dom.dart';
import 'package:html/parser.dart';
import '../../../domain/entities/AnimeListPageInfo.dart';
import '../../../domain/exceptions/CrawlerApiException.dart';
import '../../../domain/entities/parser/ihtml_parser.dart';
import '../../../external/anitube/parser/anitube_elements_name.dart';
import '../../../external/anitube/parser/anitube_item_parser_utils.dart';

class AnimeListPageParser implements IHTMLParser<AnimeListPageInfo> {
  final bool isSearch;

  AnimeListPageParser({required this.isSearch});

  @override
  AnimeListPageInfo parseHTML(
    String? html,
  ) {
    if (html == null)
      throw ParserException(message: "AnimeListPageParser html is null");
    return AnimeListPageInfo.fromJson(
        _parseAnimeListPage(html, isSearch: isSearch));
  }

  Map<String, dynamic> _parseAnimeListPage(String page,
      {bool isSearch = false}) {
    var body = parse(page).getElementsByTagName('body')[0];

    try {
      var animeItems = _parseAnimeItems(
          body,
          isSearch
              ? _AnimeListPageClasses.SEARCH_CONTAINER
              : _AnimeListPageClasses.ANIME_LIST);

      var paginationInfo = _parsePaginationData(body);

      return {
        AnimeListPageInfo.ANIME_ITEMS: animeItems,
        AnimeListPageInfo.CURRENT_PAGE:
            paginationInfo[AnimeListPageInfo.CURRENT_PAGE],
        AnimeListPageInfo.MAX_PAGE_NUMBER:
            paginationInfo[AnimeListPageInfo.MAX_PAGE_NUMBER]
      };
    } catch (ex) {
      print(
          'Error in parsing process. AnimeListPageParser::parseAnimeListPage\n$ex');
      throw ParserException(message: "Error parsing anime list page");
    }
  }

  List<Map<String, dynamic>> _parseAnimeItems(
      Element body, String containerClassName) {
    var container = body.getElementsByClassName(containerClassName);
    Element elementList;
    List<Map<String, dynamic>> resultsList = [];

    if (container.isNotEmpty) {
      elementList = container[0];

      try {
        if (elementList.children.isNotEmpty) {
          // verifying if there data available
          if (elementList.children[0].attributes['class'] !=
              _AnimeListPageClasses.LIST_NOT_FOUND) {
            for (int i = 0; i < elementList.children.length; i++) {
              try {
                //AnitubeElementName.ANI_ITEM_IMG,
                // AnitubeElementName.ANI_CC
                var item = parseItem(elementList.children[i],
                    AnitubeElementName.ANI_ITEM_IMG, AnitubeElementName.ANI_CC);
                resultsList.add(item);
              } catch (ex) {
                print(
                    'AnimeListPageParser::_parseAnimeItems when try parseItem $ex');
                throw ParserException(message: ex.toString());
              }
            }
            return resultsList;
          }
        }
      } catch (ex) {
        print('AnimeListParser::_parseAnimeItems ${ex.toString()}');
        throw ParserException(message: '${ex.toString()}');
      }
    }

    return resultsList;
  }

  Map<String, dynamic> _parsePaginationData(Element body) {
    try {
      var currentPageNumber, totalPageNumber;
      currentPageNumber = totalPageNumber = '0';

      var elementList =
          body.getElementsByClassName(_AnimeListPageClasses.PAGINATION);

      if (elementList.isNotEmpty) {
        if (elementList.length > 0) {
          var paginationDiv = elementList[0];

          currentPageNumber = paginationDiv
              .getElementsByClassName(_AnimeListPageClasses.CURRENT)[0]
              .text;

          totalPageNumber = currentPageNumber;

          for (var i = 0; i < paginationDiv.children.length; i++) {
            var element = paginationDiv.children[i];

            if (element.attributes['class']
                    ?.contains(_AnimeListPageClasses.NEXT) ??
                false) {
              totalPageNumber = paginationDiv.children[i - 1].text;
            }
          }
        }
      }

      return {
        AnimeListPageInfo.CURRENT_PAGE: currentPageNumber,
        AnimeListPageInfo.MAX_PAGE_NUMBER: totalPageNumber,
      };
    } catch (ex) {
      print('AnimeListParser::_parsePaginationData ${ex.toString()}');
      throw ParserException(message: ex.toString());
    }
  }
}

class _AnimeListPageClasses {
  static const SEARCH_CONTAINER = "searchPagContainer";
  static const PAGINATION = "paginacao";
  static const ANIME_LIST = "listaPagAnimes";
  static const LIST_NOT_FOUND = "listaPagNotfound";
  //static const PREV = "prev";
  static const PAGE_NUMBERS = "page-numbers";
  static const NEXT = "next";
  //static const DOTS = "dots"; // Na paginacao apos o element com dots, esta o numero maximo de paginas.
  static const CURRENT =
      "current"; // na paginacao indica o numero da pagina atual
}
