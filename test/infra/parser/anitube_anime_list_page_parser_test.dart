import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/entities/AnimeListPageInfo.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anime_list_page_parser.dart';
import 'package:anitube_crawler_api/test_resources/anime_list_page.dart';
import 'package:test/test.dart';

main() {
  AnimeListPageParser parser;

  setUp(() {
    parser = AnimeListPageParser(isSearch: true);
  });

  tearDown(() {
    parser = null;
  });

  test("AnimeListPageParser parsing success test", () {
    final data = parser.parseHTML(anime_list_page);
    expect(data, isA<AnimeListPageInfo>());
    expect(data.animes != null, true);
    expect(data.animes.length > 0, true);
    expect(data.pageNumber != null, true);
    expect(data.maxPageNumber != null, true);
  });

  test("AnimeListPageParser parsing faliure with ParserException", () {
    expect(
        () => parser.parseHTML(null), throwsA(TypeMatcher<ParserException>()));
  });
}
