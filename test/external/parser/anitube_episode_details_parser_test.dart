import 'package:anitube_crawler_api/src/domain/entities/EpisodeDetails.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_episode_details_page_parser.dart';
import 'package:test/test.dart';
import '../../test_resources/episode_details_page.dart';

main() {
  AnitubeEpisodeDetailsPageParser parser = AnitubeEpisodeDetailsPageParser();

  test("AnitubeEpisodeDetailsPageParser parser success", () {
    final details = parser.parseHTML(episode_details_page);
    expect(details, isA<EpisodeDetails>());
    expect(details.streamingUrl.isNotEmpty, true);
  });

  test("AnitubeEpisodeDetailsPageParser parser failure", () {
    expect(
        () => parser.parseHTML(null), throwsA(TypeMatcher<ParserException>()));
  });
}
