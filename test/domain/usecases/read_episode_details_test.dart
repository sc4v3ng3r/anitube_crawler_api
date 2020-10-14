import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_episode_details.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_episode_details_page_parser.dart';
import 'package:anitube_crawler_api/src/infra/repository/episode_details_repository.dart';
import 'package:anitube_crawler_api/test_resources/episode_details_page.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockedRepository extends Mock implements EpisodeRepository {}

main() {
  MockedRepository repository;
  AnitubeEpisodeDetailsPageParser parser;
  String episodeId;
  ReadEpisodeDetails usecase;

  setUp(() {
    repository = MockedRepository();
    parser = AnitubeEpisodeDetailsPageParser();
    episodeId = "1234";
    usecase = ReadEpisodeDetails(parser: parser, repository: repository);
  });

  tearDown(() {
    usecase = null;
    repository = null;
    parser = null;
    episodeId = null;
  });

  test("Get Anime Details with Success", () {
    when(repository.getEpisodeDetails(episodeId))
        .thenAnswer((realInvocation) async => episode_details_page);

    final data = usecase.getEpisodeDetails(episodeId);
    expect(data != null, true);
  });

  test("Get Anime Details failure with NetworkException", () {
    when(repository.getEpisodeDetails(episodeId))
        .thenThrow(NetworkException(message: "Error 404"));
    expect(() => usecase.getEpisodeDetails(episodeId),
        throwsA(TypeMatcher<NetworkException>()));
  });

  test("Get Anime Details failure with ParserException", () {
    when(repository.getEpisodeDetails(episodeId))
        .thenAnswer((realInvocation) => null);
    expect(() => usecase.getEpisodeDetails(episodeId),
        throwsA(TypeMatcher<ParserException>()));
  });
}
