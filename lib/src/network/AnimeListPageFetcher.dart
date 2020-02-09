part of anitube_crawler_api;

enum AnimeType { LEGEND, DUBBED }

class AnimeListPageFetcher extends PageFetcher {
  AnimeListPageFetcher() : super();

  Future<String> search(String searchQuery,
      {int pageNumber = 1, int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page;
    if (pageNumber <= 0) pageNumber = 1;

    var path = AnitubePath.BASE_PATH +
        AnitubePath.PAGE +
        '$pageNumber/?s=${_handleQueryParam(searchQuery)}';

    try {
      Response response = await dio.get(path,
          options: Options(
            connectTimeout: timeout,
            receiveTimeout: timeout,
            sendTimeout: timeout,
            headers: { 'user-agent': UserAgents.generateAgent() }
          ));
      page = response.data;
    } on DioError catch (ex) {
      print('AnimeListPageFetcher::fetchAnimeListPage $ex');
      switch (ex.type) {
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
        case DioErrorType.CONNECT_TIMEOUT:
          throw TimeoutException(message: ex.message);
          break;

        // case DioErrorType.RESPONSE:
        // case DioErrorType.CANCEL:
        // case DioErrorType.DEFAULT:
        default:
          throw NetworkException(message: ex.message);
          break;
      }
    }

    return page;
  }

  String _handleQueryParam(String param) {
    if (param.contains(' ')) {
      param = param.replaceAll(RegExp(r' '), '+');
    }

    return param;
  }

  Future<String> fetchAnimeListPage(
      {AnimeType animeType = AnimeType.LEGEND,
      int pageNumber = 1,
      String startWith = '',
      int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page;

    if (pageNumber <= 0) pageNumber = 1;

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
    } on DioError catch (ex) {
      print('AnimeListPageFetcher::fetchAnimeListPage $ex');
      switch (ex.type) {
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
        case DioErrorType.CONNECT_TIMEOUT:
          throw TimeoutException(message: ex.message);
          break;

        // case DioErrorType.RESPONSE:
        // case DioErrorType.CANCEL:
        // case DioErrorType.DEFAULT:
        default:
          throw NetworkException(message: ex.message);
          break;
      }
    }

    return page;
  }
}
