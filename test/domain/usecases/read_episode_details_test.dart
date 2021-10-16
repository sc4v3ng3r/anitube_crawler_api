import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_episode_details.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_episode_details_page_parser.dart';
import 'package:anitube_crawler_api/src/infra/repository/episode_details_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../test_resources/episode_details_page.dart';

class MockedRepository extends Mock implements EpisodeRepository {}

main() {
  MockedRepository repository = MockedRepository();
  AnitubeEpisodeDetailsPageParser parser = AnitubeEpisodeDetailsPageParser();
  String episodeId = "1234";
  ReadEpisodeDetails usecase =
      ReadEpisodeDetails(parser: parser, repository: repository);

  test("Get Anime Details with Success", () async {
    when(() => repository.getEpisodeDetails(episodeId))
        .thenAnswer((realInvocation) async => episode_details_page);
    final data = await usecase.getEpisodeDetails(episodeId);
    expect(data, isA<EpisodeDetails>());
  });

  test("Get Anime Details failure with NetworkException", () {
    when(() => repository.getEpisodeDetails(episodeId))
        .thenThrow(NetworkException(message: "Error 404"));
    expect(() => usecase.getEpisodeDetails(episodeId),
        throwsA(TypeMatcher<NetworkException>()));
  });

  test("Get Anime Details failure with ParserException", () {
    when(() => repository.getEpisodeDetails(episodeId))
        .thenAnswer((realInvocation) async => "");
    expect(() => usecase.getEpisodeDetails(episodeId),
        throwsA(TypeMatcher<ParserException>()));
  });
}
