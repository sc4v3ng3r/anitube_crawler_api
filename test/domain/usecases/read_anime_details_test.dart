import '../../test_resources/anime_details_page.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ianime_details_repository.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_anime_details.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_anime_details_parser.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:anitube_crawler_api/src/domain/entities/AnimeDetails.dart';

class MockedRepository extends Mock implements IAnimeDetailsRepository {}

class MockedParser extends Mock implements IHTMLParser {}

main() {
  group("Read anime details usecase test group", () {
    MockedRepository repository = MockedRepository();
    IHTMLParser<AnimeDetails> parser = AnitubeAnimeDetailsParser();
    ReadAnimeDetails readAnimeDetails =
        ReadAnimeDetails(parser: parser, repository: repository);
    String animeId = "1234";

    test(
      "Read anime details with success",
      () async {
        when(() => repository.getAnimeDetails(animeId))
            .thenAnswer((realInvocation) async => anime_details_page_html);

        final details =
            await readAnimeDetails.getAnimeDetails(animeId: animeId);
        expect(details, isA<AnimeDetails>());
      },
    );

    test(
      "Read anime details failure with NetworkException",
      () {
        when(() => repository.getAnimeDetails(animeId))
            .thenThrow(NetworkException(message: "No network available"));

        expect(readAnimeDetails.getAnimeDetails(animeId: animeId),
            throwsA(TypeMatcher<NetworkException>()));
      },
    );
  });
}
