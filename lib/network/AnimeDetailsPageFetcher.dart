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
    } catch (ex) {
      print("AnimeDetailsPageFetcher::getAnimeDetailsPage $ex");
    }

    return page;
  }
}
