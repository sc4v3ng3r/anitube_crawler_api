import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions());

  final api = AniTubeApi(dio);

  try {
    final homePage = await api.getHomePageData();
    final genres = await api.getGenresAvailable();
    final search = await api.search("shingeki");

    print("search results");
    search.animes.forEach((element) {
      print(element.title);
    });

    print("Genres");
    genres.forEach((element) => print(element.title));

    print('========== MOST RECENT ANIMES ==========');
    homePage.mostRecentAnimes
        .forEach((animeItem) => print(animeItem.toString()));
    print('========================================\n');

    print('========== MOST SHOWED ANIMES ==========');
    homePage.mostShowedAnimes
        .forEach((animeItem) => print(animeItem.toString()));
    print('========================================\n');

    print('========== LATEST EPISODES =============');
    homePage.latestEpisodes
        .forEach((episodeItem) => print(episodeItem.toString()));
    print('========================================\n');
  } on CrawlerApiException catch (ex) {
    print('${ex.errorType} -> ${ex.message}');
  }
}
