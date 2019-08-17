library anitube_crawler_api;

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

part 'network/AnitubePath.dart';
part 'network/HomePageFetcher.dart';
part 'network/PageFetcher.dart';
part 'network/GenrePageFetcher.dart';

part 'parser/HomePageParser.dart';
part 'parser/GenrePageParser.dart';
part 'parser/ItemParser.dart';

part 'model/AnimeItem.dart';
part 'model/HomePageInfo.dart';
part 'model/EpisodeItem.dart';
part 'model/Item.dart';

class AniTubeApi {

  final HomePageFetcher _homePageFetcher = HomePageFetcher();
  final HomePageParser _homePageParser = HomePageParser();

  final GenrePageFetcher _genrePageFetcher = GenrePageFetcher();
  final GenrePageParser _genrePageParser = GenrePageParser();

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
}