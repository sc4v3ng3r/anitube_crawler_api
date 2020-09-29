library anitube_crawler_api;

import 'package:anitube_crawler_api/src/network/UserAgents.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

part 'src/network/AnitubePath.dart';
part 'src/network/HomePageFetcher.dart';
part 'src/network/PageFetcher.dart';
part 'src/network/GenrePageFetcher.dart';
part 'src/network/AnimeListPageFetcher.dart';
part 'src/network/AnimeDetailsPageFetcher.dart';
part 'src/network/EpisodeDetailsPageFetcher.dart';
part 'src/network/EpisodeVideoPageFetcher.dart';

part 'src/parser/HomePageParser.dart';
part 'src/parser/GenrePageParser.dart';
part 'src/parser/ItemParser.dart';
part 'src/parser/AnimeListPageParser.dart';
part 'src/parser/AnimeDetailsPageParser.dart';
part 'src/parser/EpisodeDetailsPageParser.dart';
part 'src/parser/VideoPageParser.dart';

part 'src/domain/entities/AnimeItem.dart';
part 'src/domain/entities/HomePageInfo.dart';
part 'src/domain/entities/AnimeListPageInfo.dart';
part 'src/domain/entities/EpisodeItem.dart';
part 'src/domain/entities/Item.dart';
part 'src/domain/entities/AnimeDetails.dart';
part 'src/domain/entities/EpisodeDetails.dart';
part 'src/exception/CrawlerApiException.dart';

///
/// AniTubeApi is a API which allows you fetch data from
/// animetube.site brazilian anime website.
///
class AniTubeApi {
  static final HomePageFetcher _homePageFetcher = HomePageFetcher();
  static final HomePageParser _homePageParser = HomePageParser();

  static final GenrePageFetcher _genrePageFetcher = GenrePageFetcher();
  static final GenrePageParser _genrePageParser = GenrePageParser();

  static final AnimeListPageFetcher _animeListPageFetcher =
      AnimeListPageFetcher();
  static final AnimeListPageParser _animeListPageParser = AnimeListPageParser();

  static final AnimeDetailsPageFetcher _animeDetailsPageFetcher =
      AnimeDetailsPageFetcher();

  static final AnimeDetailsPageParser _animeDetailsPageParser =
      AnimeDetailsPageParser();

  static final EpisodeDetailsPageFetcher _episodeDetailsPageFetcher =
      EpisodeDetailsPageFetcher();

  static final EpisodeDetailsPageParser _episodeDetailsPageParser =
      EpisodeDetailsPageParser();

  // final EpisodeVideoPageFetcher _videoPageFetcher = EpisodeVideoPageFetcher();

  /// This method fetch the animetube.site website home page with all
  /// info available. It returns a HomePageInfo object with the data
  /// and info available on website home page .
  ///
  /// [timeout] : The request timeout limit in ms.
  Future<HomePageInfo> getHomePageData(
      {int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = await _homePageFetcher.fetchHomePage(timeout: timeout);

    var latestEpisodes = _homePageParser
        .extractLatestEpisodes(page)
        .map((json) => EpisodeItem.fromJson(json))
        .toList();

    var mostRecentAnimesList = _homePageParser
        .extractRecentAnimes(page)
        .map((json) => AnimeItem.fromJson(json))
        .toList();

    var mostShowedAnimes = _homePageParser
        .extractMostShowedAnimes(page)
        .map((json) => AnimeItem.fromJson(json))
        .toList();

    var dayReleases = _homePageParser
        .extractDayRelease(page)
        .map((json) => AnimeItem.fromJson(json))
        .toList();

    return HomePageInfo(
        mostRecentAnimesList, mostShowedAnimes, latestEpisodes, dayReleases);
  }

  /// This method fetches a list of all genres available
  /// animetube.site website.
  Future<List<String>> getGenresAvailable(
      {int timeout = PageFetcher.TIMEOUT_MS}) async {
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
  Future<AnimeListPageInfo> getAnimeListPageData(
      {int pageNumber = 1,
      String startWith = '',
      AnimeType animeType = AnimeType.LEGEND,
      int timeout = PageFetcher.TIMEOUT_MS}) async {
    var page = await _animeListPageFetcher.fetchAnimeListPage(
      animeType: animeType,
      startWith: startWith,
      timeout: timeout,
      pageNumber: pageNumber,
    );

    Map<String, dynamic> pageInfoMap =
        _animeListPageParser.parseAnimeListPage(page);
    return AnimeListPageInfo.fromJson(pageInfoMap);
  }

  /// This methods returns details about an specified anime.
  /// It returns a AnimeDetails object instance.
  /// [animeId] : The anime id to get details info.
  Future<AnimeDetails> getAnimeDetails(String animeId,
      {int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = await _animeDetailsPageFetcher.getAnimeDetailsPage(animeId,
        timeout: timeout);

    var detailsData = _animeDetailsPageParser.parseAnimeDetailsPage(page);
    return AnimeDetails.fromJson(detailsData);
  }

  /// This methods returns details about an specified Episode like
  /// streaming url.
  /// It returns a EpisodeDetails object instance.
  /// [episodeId] : The episode id to get details info.
  Future<EpisodeDetails> getEpisodeDetails(String episodeId,
      {int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = await _episodeDetailsPageFetcher.getEpisodePage(episodeId,
        timeout: timeout);

    var jsonData = _episodeDetailsPageParser.parseEpisodeDetailsPage(page);

    // var videoPage = await _videoPageFetcher
    //     .getVideoPage(jsonData[EpisodeDetails.STREAM_URL], timeout: timeout);

    // jsonData[EpisodeDetails.STREAM_URL] =
    //     VideoPageParser.getStreamUrl(videoPage);

    return EpisodeDetails.fromJson(jsonData);
  }

  /// This method do the search by animes matching [query] param.
  /// Query param can be anime name, part of the name or a genre name.
  /// [query] The search query. Can't be null.
  /// [timeout] The time out limit on miliseconds. The default time is 8 seconds
  /// or 8000 miliseconds.
  /// [pageNumber] The anitube site page number to load.
  Future<AnimeListPageInfo> search(String query,
      {int pageNumber = 1, int timeout = PageFetcher.TIMEOUT_MS}) async {
    String page = await _animeListPageFetcher.search(query,
        pageNumber: pageNumber, timeout: timeout);

    var data = _animeListPageParser.parseAnimeListPage(page, isSearch: true);
    return AnimeListPageInfo.fromJson(data);
  }
}
