library anitube_crawler_api;

import 'package:dio/dio.dart';
import './domain/entities/enums.dart';
import './domain/entities/genre.dart';
import './domain/usecases/anime_search.dart';
import './domain/usecases/read_anime_details.dart';
import './domain/usecases/read_anime_feed.dart';
import './domain/usecases/read_episode_details.dart';
import './domain/usecases/read_genres.dart';
import './domain/usecases/read_home_page.dart';
import './external/anitube/anitube_data_source.dart';
import './external/anitube/parser/anime_list_page_parser.dart';
import './external/anitube/parser/anitube_anime_details_parser.dart';
import './external/anitube/parser/anitube_episode_details_page_parser.dart';
import './external/anitube/parser/anitube_genres_parser.dart';
import './external/anitube/parser/anitube_home_page_parser.dart';
import './infra/repository/anime_details_repository.dart';
import './infra/repository/anime_feed_repository.dart';
import './infra/repository/episode_details_repository.dart';
import './infra/repository/genre_repository.dart';
import './infra/repository/home_page_repository.dart';
import './infra/repository/search_repository.dart';
import './domain/entities/AnimeDetails.dart';
import './domain/entities/AnimeListPageInfo.dart';
import './domain/entities/EpisodeDetails.dart';
import './domain/entities/HomePageInfo.dart';

export 'domain/entities/AnimeDetails.dart';
export 'domain/entities/EpisodeDetails.dart';
export 'domain/entities/AnimeItem.dart';
export 'domain/entities/EpisodeItem.dart';
export 'domain/entities/HomePageInfo.dart';
export 'domain/entities/AnimeListPageInfo.dart';
export 'domain/entities/genre.dart';
export 'domain/entities/enums.dart';
export 'domain/exceptions/CrawlerApiException.dart';

///
/// AniTubeApi is a API which allows you fetch data from
/// animetube.site brazilian anime website.
///
class AniTubeApi {
  final Dio dioClient;

  ReadHomePage _homePageModule;
  ReadGenres _genresModule;
  ReadEpisodeDetails _episodeDetailsModule;
  ReadAnimeFeed _feedModule;
  ReadAnimeDetails _animeDetailsModule;
  AnimeSearch _searchModule;
  final AnitubeDataSource _dataSource;

  AniTubeApi(this.dioClient)
      : assert(dioClient != null),
        _dataSource = AnitubeDataSource(dioClient) {
    _homePageModule = ReadHomePage(
        parser: AnitubeHomePageParser(),
        homeRepository: HomePageRepository(_dataSource));

    _genresModule = ReadGenres(
        parser: AnitubeGenreParser(), repository: GenreRepository(_dataSource));

    _episodeDetailsModule = ReadEpisodeDetails(
        parser: AnitubeEpisodeDetailsPageParser(),
        repository: EpisodeRepository(_dataSource));

    _feedModule = ReadAnimeFeed(
        parser: AnimeListPageParser(isSearch: false),
        feedRepository: AnimeFeedRepository(_dataSource));

    _animeDetailsModule = ReadAnimeDetails(
        parser: AnitubeAnimeDetailsParser(),
        repository: AnimeDetailsRepository(dataSource: _dataSource));

    _searchModule = AnimeSearch(
        AnimeListPageParser(isSearch: true), SearchRepository(_dataSource));
  }

  /// This method fetches a list of all genres available
  /// animetube.site website.
  Future<List<Genre>> getGenresAvailable() async => _genresModule.getGenres();

  /// This method fetch the animetube.site website home page with all
  /// info available. It returns a HomePageInfo object with the data
  /// and info available on website home page.
  Future<HomePageInfo> getHomePageData() => _homePageModule.getHomePage();

  /// This method returns the data available on anime list page
  /// from animetube.site website. It returns an AnimeListPageInfo object
  /// instance will data and info on that page.
  /// [pageNumber] : The animes feed page number.
  /// with specified letter. The default value is an empty string.
  /// [ccType] : The closed caption type of the animes to be returned. Can be DUBBED or LEGENDED. The
  /// default values is LEGEND.
  Future<AnimeListPageInfo> getAnimeListPageData({
    int pageNumber = 1,
    AnimeCC ccType = AnimeCC.LEGENDED,
  }) =>
      _feedModule.getAnimesFeed(ccType: ccType, pageNumber: pageNumber);

  /// This methods returns details about an specified anime.
  /// It returns a AnimeDetails object instance.
  /// [animeId] : The anime id to get details info.
  Future<AnimeDetails> getAnimeDetails(String animeId) =>
      _animeDetailsModule.getAnimeDetails(animeId: animeId);

  /// This methods returns details about an specified Episode like
  /// streaming url.
  /// It returns a EpisodeDetails object instance.
  /// [episodeId] : The episode id to get details info.
  Future<EpisodeDetails> getEpisodeDetails(
    String episodeId,
  ) =>
      _episodeDetailsModule.getEpisodeDetails(episodeId);

  /// This method do the search by animes matching [query] param.
  /// Query param can be anime name, part of the name or a genre name.
  /// [query] The search query. Can't be null.
  /// [pageNumber] The anitube site page number to load.
  Future<AnimeListPageInfo> search(String query, {int pageNumber = 1}) =>
      _searchModule.search(query, pageNumber: pageNumber);
}
