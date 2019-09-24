part of anitube_crawler_api;

class AnimeDetailsPageFetcher extends PageFetcher {
  AnimeDetailsPageFetcher() : super();

  Future<String> getAnimeDetailsPage(String animeId,
      {int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = "";

    try {
      Response response = await dio.get(
        AnitubePath.BASE_PATH + animeId,
        options: Options(
          sendTimeout: timeout,
          receiveTimeout: timeout,
          connectTimeout: timeout,
        ),
      );

      page = response.data;
    } 
    on DioError catch (ex) {
      print("AnimeDetailsPageFetcher::getAnimeDetailsPage exception");
      switch(ex.type){
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
