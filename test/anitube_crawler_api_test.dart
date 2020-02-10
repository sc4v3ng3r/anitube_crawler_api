import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var localTimeout = 10000; // defining 10 seconds for timeout
  AniTubeApi api = AniTubeApi();
  HomePageInfo homePage;

  AnimeDetails animeDetails;
  EpisodeDetails episodeDetails;

  // ====  Home page group ====
  group('HomePage test group\n', () {
    setUp(() async =>
        homePage = await api.getHomePageData(timeout: localTimeout));
    test('When encountred home page info data', () {
      expect(((homePage != null)), true);
    });

    test('Checking day releases data', () {
      expect(((homePage.dayReleases != null)), true);
    });

    test('Checking latest episodes data', () {
      expect(((homePage.latestEpisodes != null)), true);
    });

    test('Checking most recent animes data', () {
      expect(((homePage.mostRecentAnimes != null)), true);
    });

    test('Checking most showed animes data', () {
      expect(((homePage.mostShowedAnimes != null)), true);
    });
  });

  // Anime details
  group('Anime details group\n', () {
    setUp(() async => animeDetails = await api.getAnimeDetails(
        homePage.mostRecentAnimes[0].id,
        timeout: localTimeout));

    test('Test getting anime details instance', () {
      expect((animeDetails != null), true);
    });

    test('Test checking anime details properties', () {
      expect(
        (animeDetails.imageUrl != null),
        true,
      );
      expect((animeDetails.resume != null), true);
      expect((animeDetails.studio != null), true);
      expect((animeDetails.title != null), true);
      expect((animeDetails.year != null), true);
      expect((animeDetails.genre != null), true);
      expect((animeDetails.episodes != null), true);
    });
  });

  // Episode details group
  group('Episode Details group\n', () {
    // test( 'Testing episode id presence', (){
    //   expect( homePage.latestEpisodes[0].id != null, true);
    // } );
    setUp(() async {
      episodeDetails = await api.getEpisodeDetails(
          homePage.latestEpisodes[0].id,
          timeout: localTimeout);
    });

    test('Test getting episode details instance', () {
      expect(episodeDetails != null, true);
    });

    test('Test checking episode details Video streaming url property', () {
      expect(episodeDetails.streamingUrl != null, true);
    });

    test('Test checking episode details properties', () {
      expect(episodeDetails.animeId != null, true);
      expect(episodeDetails.title != null, true);
      expect(episodeDetails.referer != null, true);
    });
  });

  /// Genres test group.
  group('Genre group\n', () {
    var genreList;
    setUp( () async {
      genreList = await api.getGenresAvailable(timeout: localTimeout);
    } );

    test('Genre list test', () {
      expect( (genreList != null) , true);
    } );
  });

  // Anime & Episode details REDUNDANCY group
  group('Anime & Episode details redundancy group\n', () {
    setUp(() async {

      animeDetails = await api.getAnimeDetails(
        homePage.mostShowedAnimes[0].id,
         timeout: localTimeout
      );

    });

    test('Test getting animes  details [REDUDANCY]', () {
      expect(  animeDetails != null, true );
    });

    test('Test getting animes episode details [REDUDANCY]', ()  async {
       var data = await api.getEpisodeDetails(animeDetails.episodes[0].id,
        timeout: localTimeout);
        expect(data != null, true);
        expect( data.streamingUrl != null, true);
        expect( data.referer != null, true );
    });
  });
}