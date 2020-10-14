import 'package:anitube_crawler_api/src/domain/entities/enums.dart';
import 'package:anitube_crawler_api/src/domain/usecases/anime_search.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_anime_feed.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_data_source.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anime_list_page_parser.dart';
import 'package:anitube_crawler_api/src/infra/repository/anime_feed_repository.dart';
import 'package:anitube_crawler_api/src/infra/repository/search_repository.dart';
import 'package:dio/dio.dart';

void main() async {
  final source = AnitubeDataSource(Dio());
  final repository = SearchRepository(source);
  final parser = AnimeListPageParser(isSearch: true);
  final IAnimeSearch searchUsecase = AnimeSearch(parser, repository);

  final feedRepository = AnimeFeedRepository(source);
  final feedParser = AnimeListPageParser(isSearch: false);
  final IReadAnimeFeed animeFeed =
      ReadAnimeFeed(parser: feedParser, feedRepository: feedRepository);

  final data =
      await animeFeed.getAnimesFeed(pageNumber: 1, ccType: AnimeCC.LEGENDED);
  data.animes.forEach((element) => print(element.title));

  // final data = await searchUsecase.search("a", pageNumber: 63);

  // data.animes.forEach((element) => print(element.title));
  // var localTimeout = 7000; // defining 7 seconds timeout
  // AniTubeApi api = AniTubeApi();
  // var homePage;
  // try {
  //   // This call returns a HomePageInfo instance or throws an exception
  //   // if somethings goes wrong,
  //   homePage = await api.getHomePageData(timeout: localTimeout);

  //   print('========== MOST RECENT ANIMES ==========');
  //   homePage.mostRecentAnimes.forEach( (animeItem) => print );
  //   print('========================================\n');

  //   print('========== MOST SHOWED ANIMES ==========');
  //   homePage.mostShowedAnimes.forEach( (animeItem) => print );
  //   print('========================================\n');

  //   print('========== LATEST EPISODES =============');
  //   homePage.latestEpisodes .forEach( (episodeItem) => print );
  //   print('========================================\n');

  // } on CrawlerApiException catch (ex){
  //   print('${ex.errorType} -> ${ex.message}');
  // }
}
