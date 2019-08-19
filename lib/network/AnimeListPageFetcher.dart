part of anitube_crawler_api;

enum AnimeType {LEGEND, DUBBED}

class AnimeListPageFetcher extends PageFetcher {

  AnimeListPageFetcher() : super();

  Future<String> fetchAnimeListPage({
    AnimeType animeType = AnimeType.LEGEND,
    int pageNumber = 1,
    String startWith = '',
    int timeout = PageFetcher.TIMEOUT_MS}) async {

    String page;

    if (pageNumber <=0 )
      pageNumber = 1;

    var path = AnitubePath.ANIME_LIST_PAGE_LEGEND + "$pageNumber";

    if (animeType == AnimeType.DUBBED)
      path = AnitubePath.ANIME_LIST_PAGE_DUBBED + "$pageNumber";


    if (startWith.isNotEmpty)
      path = path + '/${AnitubePath.QUERY_LETTER}${startWith[0]}';

    try {
      Response response = await dio.get(path,
        options: Options(
          connectTimeout: timeout,
          receiveTimeout: timeout,
          sendTimeout: timeout,
        ));
      page = response.data;
    }

    catch(ex){
      print('AnimeListPageFetcher::fetchAnimeListPage $ex');
    }

    return page;
  }
}