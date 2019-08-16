part of anitube_crawler_api;


class HomePageFetcher extends PageFetcher {

  HomePageFetcher();

  Future<String> fetchHomePage({int timeout = PageFetcher.TIMEOUT_MS}) async {

    String page = "";

    try {
      Response resp = await _dio.get(AnitubePath.HOME_PAGE,
          options: Options(
            connectTimeout: timeout,
            receiveTimeout: timeout,
            sendTimeout: timeout,

          ),
      );

      page = resp.data;
    }

    catch (ex){
      print('HomePageFetcher::fetchHomePage() $ex');
    }

    return page;
  }
}