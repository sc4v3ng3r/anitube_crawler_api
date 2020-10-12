// import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:anitube_crawler_api/src/domain/entities/HomePageInfo.dart';
import 'package:anitube_crawler_api/test_resources/home_page.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ihome_repository.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:mockito/mockito.dart';

class MockedHomeRepository extends Mock implements IHomeRepository {}

// class MockedHomePageParser extends Mock implements IHTMLParser {}

main() {
  IHomeRepository homeRepository;
  // IHTMLParser homeParser;
  IReadHomePage usecase;

  setUp(() {
    homeRepository = MockedHomeRepository();
    // homeParser = MockedHomePageParser();
    usecase = ReadHomePage(homeRepository: homeRepository);
  });

  tearDown(() {
    usecase = null;
    homeRepository = null;
  });

  test("ReadHomePage usecase success", () async {
    when(
      homeRepository.getHomePage(),
    ).thenAnswer((realInvocation) async => HomePageInfo([], [], [], []));
    final homePageInfo = await usecase.getHomePage();
    expect(homePageInfo != null, true);
  });

  test("ReadHomePage usecase Failure", () {
    when(homeRepository.getHomePage())
        .thenThrow(NetworkException(message: "No network available"));
    expect(() => usecase.getHomePage(), throwsException);
  });
}
