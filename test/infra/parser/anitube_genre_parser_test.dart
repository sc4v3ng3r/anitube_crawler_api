import 'dart:io';
import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_genres_parser.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data/paths.dart';

main() {
  IHTMLParser<List<Genre>> parser;

  setUp(() {
    parser = AnitubeGenreParser();
  });

  group("AnitubeGenreParser test group", () {
    test("Running anitube_genre_parser with success", () async {
      print(Directory.current.path);
      final html = File(MOCKED_GENRES_HTML_PAGE).readAsStringSync();

      final list = parser.parseHTML(html);
      expect(list, isA<List<Genre>>());
      expect(list.isNotEmpty, true);
    });
  });

  test("Running anitube_genre_parser with ParserException", () {
    expect(() => parser.parseHTML(null), throwsException);
  });
}
