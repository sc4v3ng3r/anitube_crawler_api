part of anitube_crawler_api;

class GenrePageFetcher extends PageFetcher {

  Future<String> getGenrePage({int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = "";

    try {
      Response resp = await dio.get(AnitubePath.GENRES_PAGE,
          options: Options(
            sendTimeout: timeout,
            receiveTimeout: timeout,
            connectTimeout: timeout,
          ));
      page = resp.data;
    }

    catch (ex){
      print('GenrePageFetcher::getGenrePage $ex');
    }

    return page;
  }
}