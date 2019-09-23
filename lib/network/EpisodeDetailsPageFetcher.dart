part of anitube_crawler_api;

class EpisodeDetailsPageFetcher extends PageFetcher {
  EpisodeDetailsPageFetcher() : super();

  Future<String> getEpisodePage(String episodeId,
      {int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page;

    try {
      Response response = await dio.get(AnitubePath.BASE_PATH + episodeId,
          options: Options(
            connectTimeout: timeout,
            receiveTimeout: timeout,
            sendTimeout: timeout,
          ));

      page = response.data;
    } on DioError catch (ex) {
      print("EpisodeDetailsPageFetcher::getEpisodePage $ex");
      
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
