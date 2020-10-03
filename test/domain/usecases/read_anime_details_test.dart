import 'dart:io';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ianime_details_repository.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_anime_details.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_anime_details_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:anitube_crawler_api/src/domain/entities/AnimeDetails.dart';
import '../../mock_data/paths.dart';

class MockedRepository extends Mock implements IAnimeDetailsRepository {}

class MockedParser extends Mock implements IHTMLParser {}

main() {
  ReadAnimeDetails readAnimeDetails;
  MockedRepository repository;
  IHTMLParser parser;

  group("Read anime details usecase test group", () {
    String animeId;
    setUp(() {
      repository = MockedRepository();
      parser = AnitubeAnimeDetailsParser();
      readAnimeDetails =
          ReadAnimeDetails(parser: parser, repository: repository);
      animeId = "1234";
    });

    test(
      "Read anime details with success",
      () async {
        when(repository.getAnimeDetails(animeId)).thenAnswer(
            (realInvocation) async =>
                File(MOCKED_ANIME_DETAILS_HTML_PAGE).readAsStringSync());

        final details =
            await readAnimeDetails.getAnimeDetails(animeId: animeId);
        expect(details != null, true);
        expect(details, isA<AnimeDetails>());
      },
    );

    test(
      "Read anime details failure with NetworkException",
      () {
        when(repository.getAnimeDetails(animeId))
            .thenThrow(NetworkException(message: "No network available"));

        expect(readAnimeDetails.getAnimeDetails(animeId: animeId),
            throwsException);
      },
    );
  });
}
