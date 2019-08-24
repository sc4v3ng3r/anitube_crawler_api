library anitube_crawler_api;

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

part 'network/AnitubePath.dart';
part 'network/HomePageFetcher.dart';
part 'network/PageFetcher.dart';
part 'network/GenrePageFetcher.dart';
part 'network/AnimeListPageFetcher.dart';
part 'network/AnimeDetailsPageFetcher.dart';
part 'network/EpisodeDetailsPageFetcher.dart';

part 'parser/HomePageParser.dart';
part 'parser/GenrePageParser.dart';
part 'parser/ItemParser.dart';
part 'parser/AnimeListPageParser.dart';
part 'parser/AnimeDetailsPageParser.dart';
part 'parser/EpisodeDetailsPageParser.dart';

part 'model/AnimeItem.dart';
part 'model/HomePageInfo.dart';
part 'model/AnimeListPageInfo.dart';
part 'model/EpisodeItem.dart';
part 'model/Item.dart';
part 'model/AnimeDetails.dart';
part 'model/EpisodeDetails.dart';

///
/// AniTubeApi is a API which allows you fetch data from
/// animetube.site brazilian anime website.
///
class AniTubeApi {

  final HomePageFetcher _homePageFetcher = HomePageFetcher();
  final HomePageParser _homePageParser = HomePageParser();

  final GenrePageFetcher _genrePageFetcher = GenrePageFetcher();
  final GenrePageParser _genrePageParser = GenrePageParser();

  final AnimeListPageFetcher _animeListPageFetcher = AnimeListPageFetcher();
  final AnimeListPageParser _animeListPageParser = AnimeListPageParser();

  final AnimeDetailsPageFetcher _animeDetailsPageFetcher = AnimeDetailsPageFetcher();
  final AnimeDetailsPageParser _animeDetailsPageParser = AnimeDetailsPageParser();

  final EpisodeDetailsPageFetcher _episodeDetailsPageFetcher = EpisodeDetailsPageFetcher();
  final EpisodeDetailsPageParser _episodeDetailsPageParser = EpisodeDetailsPageParser();

  /// This method fetch the animetube.site website home page with all
  /// info available. It returns a HomePageInfo object with the data
  /// and info available on website home page .
  ///
  /// [timeout] : The request timeout limit in ms.
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

  /// This method fetches a list of all genres available
  /// animetube.site website.
  Future<List<String>> getGenresAvailable(
      {int timeout = PageFetcher.TIMEOUT_MS} ) async {
    String page = await _genrePageFetcher.getGenrePage(timeout: timeout);

    return _genrePageParser.getGenresAvailable(page);
  }

  /// This method returns the data available on anime list page
  /// from animetube.site website. It returns an AnimeListPageInfo object
  /// instance will data and info on that page.
  /// [pageNumber] : The number of animes page.
  /// [startWith] : A query param to returns only animes that start
  /// with specified letter. The default value is an empty string.
  /// [animeType] : The type of animes to be returned. Can be DUBBED or LEGEND. The
  /// default values is LEGEND.
  /// [timeout] : The request timeout limit in ms.
  Future<AnimeListPageInfo> getAnimeListPageData({
    int pageNumber = 1,
    String startWith = '',
    AnimeType animeType = AnimeType.LEGEND,
    int timeout = PageFetcher.TIMEOUT_MS
  }) async {
    var page = await _animeListPageFetcher.fetchAnimeListPage(
      animeType: animeType,
      startWith: startWith,
      timeout: timeout,
      pageNumber: pageNumber,
    );

    Map<String,dynamic> pageInfoMap = _animeListPageParser.parseAnimeListPage(page);
    return AnimeListPageInfo.fromJson( pageInfoMap );
  }

  /// This methods returns details about an specified anime.
  /// It returns a AnimeDetails object instance.
  /// [animeId] : The anime id to get details info.
  Future<AnimeDetails> getAnimeDetails(String animeId) async {
    String page = await _animeDetailsPageFetcher.getAnimeDetailsPage(animeId);

    var detailsData = _animeDetailsPageParser.parseAnimeDetailsPage(page);
    return AnimeDetails.fromJson( detailsData );
  }

  /// This methods returns details about an specified Episode like
  /// streaming url.
  /// It returns a EpisodeDetails object instance.
  /// [episodeId] : The episode id to get details info.
  Future<EpisodeDetails> getEpisodeDetails(String episodeId) async {
    String page = await _episodeDetailsPageFetcher.getEpisodePage(episodeId);

    var jsonData = _episodeDetailsPageParser.parseEpisodeDetailsPage(page);
    return EpisodeDetails.fromJson(jsonData);

  }
}