import 'dart:io';
import 'package:anitube_crawler_api/src/domain/entities/AnimeDetails.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_anime_details_parser.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data/paths.dart';

main() {
  AnitubeAnimeDetailsParser parser;
  setUp(() {
    parser = AnitubeAnimeDetailsParser();
  });

  group("AnitubeAnimeDetailsParser test", () {
    test("AnituneAnimeDetails page parser with success", () {
      final html = File(MOCKED_ANIME_DETAILS_HTML_PAGE).readAsStringSync();
      final details = parser.parseHTML(html);
      expect(details != null, true);
      expect(details, isA<AnimeDetails>());
    });

    test("AnituneAnimeDetails page parser with fail", () {
      expect(() => parser.parseHTML(null), throwsException);
    });
  });
}
