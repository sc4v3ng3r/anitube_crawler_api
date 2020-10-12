import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_genres_parser.dart';
import 'package:anitube_crawler_api/test_resources/genres_page.dart';
import 'package:test/test.dart';

main() {
  IHTMLParser<List<Genre>> parser;

  setUp(() {
    parser = AnitubeGenreParser();
  });

  group("AnitubeGenreParser test group", () {
    test("Running anitube_genre_parser with success", () async {
      final list = parser.parseHTML(genre_page_html);
      expect(list, isA<List<Genre>>());
      expect(list.isNotEmpty, true);
    });
  });

  test("Running anitube_genre_parser with ParserException", () {
    expect(
        () => parser.parseHTML(null), throwsA(TypeMatcher<ParserException>()));
  });
}
