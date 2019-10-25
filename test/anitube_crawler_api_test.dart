import 'package:anitube_crawler_api/anitube_crawler_api.dart';

void main() async {
  var localTimeout = 47000; // defining 7 seconds timeout
  AniTubeApi api = AniTubeApi();
  HomePageInfo homePage;
//
//  try {
//    // This call returns a HomePageInfo instance or throws an exception
//    // if somethings goes wrong,
//    homePage = await api.getHomePageData(timeout: localTimeout);
//    print('========== MOST RECENT ANIMES ${homePage.mostRecentAnimes.length} ==========');
//    homePage.mostRecentAnimes.forEach( (animeItem) => print(animeItem) );
//    print('========================================\n');
//
//    print('========== MOST SHOWED ANIMES ${homePage.mostShowedAnimes} ==========');
//    homePage.mostShowedAnimes.forEach( (animeItem) => print(animeItem) );
//    print('========================================\n');
//
//    print('========== LATEST EPISODES ${homePage.latestEpisodes} =============');
//    homePage.latestEpisodes .forEach( (episodeItem) => print(episodeItem) );
//    print('========================================\n');
//
//
//    // getting anime info details
//    AnimeDetails animeDetails = await api.getAnimeDetails( homePage.mostShowedAnimes[3].id,
//      timeout: localTimeout);
//    // shows a lot of property and values.
//    print('===== DETAILS OF ${animeDetails.title} =====');
////    print(animeDetails);
//
//    // getting episode details by id. Returning data like streamingUrl.
//    print("---------------Getting EPISODE ID ${animeDetails.episodes[0].id}");
//    var episodeDetails = await api.getEpisodeDetails(animeDetails.episodes[0].id);
//    print(episodeDetails);
//
//    // getting all genres available
//    var genres = await api.getGenresAvailable(timeout: localTimeout);
//    // string list with all genres.
//    print(genres);
//
//    // search animes that starts with 'nar'
//    AnimeListPageInfo info = await api.search('nar', timeout: localTimeout);
//    print('current page number ${info.pageNumber}');
//    print('Total Pages number: ${info.maxPageNumber}');
//    print(info.animes);
//  }
//
//  on CrawlerApiException catch (ex){
//    print('${ex.errorType} -> ${ex.message}');
//  }

  homePage = await api.getHomePageData();

  var lancamento = await api.getAnimeDetails(homePage.dayReleases[0].id);
  print(lancamento);
}