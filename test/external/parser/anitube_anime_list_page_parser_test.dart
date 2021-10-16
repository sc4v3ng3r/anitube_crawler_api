import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/entities/AnimeListPageInfo.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anime_list_page_parser.dart';
import 'package:test/test.dart';

import '../../test_resources/anime_list_page.dart';

main() {
  AnimeListPageParser parser = AnimeListPageParser(isSearch: true);

  test("AnimeListPageParser parsing success test", () {
    final data = parser.parseHTML(anime_list_page);
    expect(data, isA<AnimeListPageInfo>());
    expect(data.animes.isNotEmpty, true);
    expect(data.pageNumber.isNotEmpty, true);
    expect(data.maxPageNumber.isNotEmpty, true);
  });

  test("AnimeListPageParser parsing faliure with ParserException", () {
    expect(
        () => parser.parseHTML(null), throwsA(TypeMatcher<ParserException>()));
  });
}
