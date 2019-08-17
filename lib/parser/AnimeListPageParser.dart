part of anitube_crawler_api;

class AnimeListPageParser {


  Map<String, dynamic> parseAnimeListPage(String page){

    var body = parse(page).getElementsByTagName('body')[0];

    var animeItems = _parseAnimeItems(body);

    var paginationInfo = _parsePaginationData(body);

    return {
      AnimeListPageInfo.ANIME_ITEMS  : animeItems,
      AnimeListPageInfo.CURRENT_PAGE : paginationInfo[AnimeListPageInfo.CURRENT_PAGE],
      AnimeListPageInfo.MAX_PAGE_NUMBER : paginationInfo[AnimeListPageInfo.MAX_PAGE_NUMBER]
    };

  }


  List<Map<String, dynamic>> _parseAnimeItems(Element body){
    var elementList = body.getElementsByClassName(_AnimeListPageClasses.ANIME_LIST)[0];

    // verifying if there data available
    if (elementList.children[0].attributes['class'] != _AnimeListPageClasses.LIST_NOT_FOUND){
      return elementList.children.map(  (item) => ItemParser.parseItem(
          item, ItemParser.ANI_ITEM_IMG, ItemParser.ANI_CC) ).toList();
    }

    return [];
  }


  Map<String, dynamic> _parsePaginationData(Element body){

    var elementList = body.getElementsByClassName(_AnimeListPageClasses.PAGINATION);
    var currentPageNumber, totalPageNumber;
    currentPageNumber = totalPageNumber = '0';

    if (elementList.length > 0){

      var paginationDiv = elementList[0];

      currentPageNumber = paginationDiv
          .getElementsByClassName(_AnimeListPageClasses.CURRENT)[0].text;

      totalPageNumber = currentPageNumber;


      for(var i =0; i < paginationDiv.children.length; i++){
        var element = paginationDiv.children[i];
        if (  element.attributes['class'].contains(_AnimeListPageClasses.NEXT)){
          totalPageNumber =  paginationDiv.children[i-1].text;
        }
      }
    }

    //print('Current Page Number $currentPageNumber');
    //print('Total Page Number $totalPageNumber');

    return {
      AnimeListPageInfo.CURRENT_PAGE : currentPageNumber,
      AnimeListPageInfo.MAX_PAGE_NUMBER : totalPageNumber,
    };

  }
}

class _AnimeListPageClasses {
  static const PAGINATION = "paginacao";
  static const ANIME_LIST = "listaPagAnimes";
  static const LIST_NOT_FOUND = "listaPagNotfound";
  //static const PREV = "prev";
  static const PAGE_NUMBERS = "page-numbers";
  static const NEXT = "next";
  //static const DOTS = "dots"; // Na paginacao apos o element com dots, esta o numero maximo de paginas.
  static const CURRENT = "current"; // na paginacao indica o numero da pagina atual
}