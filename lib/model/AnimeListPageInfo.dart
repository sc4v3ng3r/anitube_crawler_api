part of anitube_crawler_api;

/// This class holds read only info about animes list page
/// from anitube.site brazilian website.
class AnimeListPageInfo {
  static const CURRENT_PAGE = 'currentPage';
  static const MAX_PAGE_NUMBER = 'pagesNumber';
  static const ANIME_ITEMS = "animeItems";
  static const PAGINATION_INFO = "paginationInfo";

  /// All animes available in this page.
  final List<AnimeItem> animes;

  /// The current page number;
  final String pageNumber;

  /// The number of the last page. Useful to make pagination.
  final String maxPageNumber;

  AnimeListPageInfo.fromJson(Map<String, dynamic> map)
      : pageNumber = map[CURRENT_PAGE],
        maxPageNumber = map[MAX_PAGE_NUMBER],
        animes = List.from(map[ANIME_ITEMS])
            .map<AnimeItem>((itemJson) => AnimeItem.fromJson(itemJson))
            .toList();
}
