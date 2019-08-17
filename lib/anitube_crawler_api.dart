library anitube_crawler_api;

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

part 'network/AnitubePath.dart';
part 'network/HomePageFetcher.dart';
part 'network/PageFetcher.dart';
part 'network/GenrePageFetcher.dart';
part 'network/AnimeListPageFetcher.dart';

part 'parser/HomePageParser.dart';
part 'parser/GenrePageParser.dart';
part 'parser/ItemParser.dart';
part 'parser/AnimeListPageParser.dart';

part 'model/AnimeItem.dart';
part 'model/HomePageInfo.dart';
part 'model/AnimeListPageInfo.dart';
part 'model/EpisodeItem.dart';
part 'model/Item.dart';


class AniTubeApi {

  final HomePageFetcher _homePageFetcher = HomePageFetcher();
  final HomePageParser _homePageParser = HomePageParser();

  final GenrePageFetcher _genrePageFetcher = GenrePageFetcher();
  final GenrePageParser _genrePageParser = GenrePageParser();

  final AnimeListPageFetcher _animeListPageFetcher = AnimeListPageFetcher();
  final AnimeListPageParser _animeListPageParser = AnimeListPageParser();

  ///
  Future<HomePageInfo> getHomePageData({int timeout = PageFetcher.TIMEOUT_MS}) async {
    
    String page = await _homePageFetcher.fetchHomePage(timeout: timeout);

    var latestEpisodes = _homePageParser.extractLatestEpisodes(page)
        .map( (json) => EpisodeItem.fromJson(json) ).toList();

    var mostRecentAnimesList = _homePageParser.extractRecentAnimes(page)
        .map( (json) => AnimeItem.fromJson(json) ).toList();

    var mostShowedAnimes = _homePageParser.extractMostShowedAnimes(page)
        .map( (json) => AnimeItem.fromJson(json) ).toList();

    var dayReleases = _homePageParser.extractDayRelease(page)
      .map( (json) => AnimeItem.fromJson(json) ).toList();

    return HomePageInfo(mostRecentAnimesList, mostShowedAnimes,
        latestEpisodes, dayReleases);
  }


  ///
  Future<List<String>> getGenresAvailable(
      {int timeout = PageFetcher.TIMEOUT_MS} )  async{
    String page = await _genrePageFetcher.getGenrePage(timeout: timeout);

    return _genrePageParser.getGenresAvailable(page);
  }

  Future<AnimeListPageInfo> getAnimeListPageData({
    int pageNumber = 1,
    AnimeType animeType = AnimeType.LEGEND,
    int timeout = PageFetcher.TIMEOUT_MS
  }) async {
    var page = await _animeListPageFetcher.fetchAnimeListPage(
      animeType: animeType,
      timeout: timeout,
      pageNumber: pageNumber,
    );

    Map<String,dynamic> pageInfoMap = _animeListPageParser.parseAnimeListPage(page);
    return AnimeListPageInfo.fromJson( pageInfoMap );

  }

}