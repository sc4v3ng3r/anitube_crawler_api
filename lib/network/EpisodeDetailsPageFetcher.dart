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
        )
      );

      page = response.data;
    }

    catch(ex){
      print("EpisodeDetailsPageFetcher::getEpisodePage $ex");
    }

    return page;
  }

}