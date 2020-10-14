import 'package:anitube_crawler_api/src/domain/entities/EpisodeDetails.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_episode_details_page_parser.dart';
import 'package:anitube_crawler_api/test_resources/episode_details_page.dart';
import 'package:test/test.dart';

main() {
  AnitubeEpisodeDetailsPageParser parser;

  setUp(() => parser = AnitubeEpisodeDetailsPageParser());
  tearDown(() => parser = null);

  test("AnitubeEpisodeDetailsPageParser parser success", () {
    final details = parser.parseHTML(episode_details_page);
    expect(details, isA<EpisodeDetails>());
    expect(details.streamingUrl != null, true);
  });

  test("AnitubeEpisodeDetailsPageParser parser failure", () {
    expect(
        () => parser.parseHTML(null), throwsA(TypeMatcher<ParserException>()));
  });
}
