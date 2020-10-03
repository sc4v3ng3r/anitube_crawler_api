import 'package:anitube_crawler_api/src/domain/entities/AnimeDetails.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_anime_details_parser.dart';
import 'package:anitube_crawler_api/test_resources/anime_details_page.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  AnitubeAnimeDetailsParser parser;
  setUp(() {
    parser = AnitubeAnimeDetailsParser();
  });

  group("AnitubeAnimeDetailsParser test", () {
    test("AnituneAnimeDetails page parser with success", () {
      final details = parser.parseHTML(anime_details_page_html);
      expect(details != null, true);
      expect(details, isA<AnimeDetails>());
    });

    test("AnituneAnimeDetails page parser with fail", () {
      expect(() => parser.parseHTML(null), throwsException);
    });
  });
}
