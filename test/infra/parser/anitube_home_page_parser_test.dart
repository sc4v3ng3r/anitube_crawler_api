import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_home_page_parser.dart';
import 'package:anitube_crawler_api/test_resources/home_page.dart';
import 'package:test/test.dart';
import 'package:anitube_crawler_api/src/domain/entities/HomePageInfo.dart';

void main() {
  AnitubeHomePageParser parser;

  setUp(() {
    parser = AnitubeHomePageParser();
  });

  test("Home page parser test success", () {
    final homePage = parser.parseHTML(home_page_html);
    expect(homePage, isA<HomePageInfo>());
    expect(homePage != null, true);
  });

  tearDown(() {
    parser = null;
  });

  test("Home page parser failure", () {
    expect(
        () => parser.parseHTML(null), throwsA(TypeMatcher<ParserException>()));
  });
}
