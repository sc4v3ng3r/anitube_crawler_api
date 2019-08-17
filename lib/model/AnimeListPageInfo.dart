part of anitube_crawler_api;


class AnimeListPageInfo {

  static const CURRENT_PAGE = 'currentPage';
  static const MAX_PAGE_NUMBER = 'pagesNumber';
  static const ANIME_ITEMS = "animeItems";
  static const PAGINATION_INFO = "paginationInfo";

  final List<AnimeItem> animes;
  final String currentPageNumber;
  final String maxPageNumber;


  AnimeListPageInfo.fromJson( Map<String, dynamic> map ) :
        currentPageNumber = map[CURRENT_PAGE],
        maxPageNumber = map[MAX_PAGE_NUMBER],
        animes = List.from(  map[ANIME_ITEMS] ).map<AnimeItem>(
                (itemJson) => AnimeItem.fromJson(itemJson) ).toList();

}