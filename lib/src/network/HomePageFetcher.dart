part of anitube_crawler_api;

class HomePageFetcher extends PageFetcher {
  HomePageFetcher();

  Future<String> fetchHomePage({int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = "";

    try {
      Response resp = await _dio.get(
        AnitubePath.HOME_PAGE,
        options: Options(
          connectTimeout: timeout,
          receiveTimeout: timeout,
          sendTimeout: timeout,
          headers: { 'user-agent': UserAgents.generateAgent() }
        ),
      );

      page = resp.data;
    } on DioError catch (ex) {
      print('HomePageFetcher::fetchHomePage() $ex');
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
