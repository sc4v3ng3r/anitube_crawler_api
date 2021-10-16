import 'package:anitube_crawler_api/src/domain/entities/HomePageInfo.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ihome_repository.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_home_page.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_home_page_parser.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../test_resources/home_page.dart';

class MockedHomeRepository extends Mock implements IHomeRepository {}

main() {
  final IHomeRepository homeRepository = MockedHomeRepository();
  final IReadHomePage usecase = ReadHomePage(
      parser: AnitubeHomePageParser(), homeRepository: homeRepository);

  test("ReadHomePage usecase success", () async {
    when(
      () => homeRepository.getHomePage(),
    ).thenAnswer((realInvocation) async => home_page_html);
    final homePageInfo = await usecase.getHomePage();
    expect(homePageInfo, isA<HomePageInfo>());
  });

  test("ReadHomePage usecase Failure", () {
    when(() => homeRepository.getHomePage())
        .thenThrow(NetworkException(message: "No network available"));

    expect(
        () => usecase.getHomePage(), throwsA(TypeMatcher<NetworkException>()));
  });
}
