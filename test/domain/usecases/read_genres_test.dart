import 'dart:io';
import 'dart:math';
import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/igenre_repository.dart';
import 'package:anitube_crawler_api/src/domain/usecases/read_genres.dart';
import 'package:anitube_crawler_api/src/external/anitube/parser/anitube_genres_parser.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockedRepository extends Mock implements IGenreRepository {}

// class MockedAPI extends Mock implements IHTMLPageFetcher {}

// // ignore: non_constant_identifier_names
main() {
  test("No tests available yet", () => expect(true, true));
//   // group("READ GENRES USE CASE TEST", () {
//   //   IGenreRepository repository;
//   //   ReadGenres useCase;
//   //   IHTMLParser<List<Genre>> parser;

//   //   setUp(() {
//   //     repository = MockedRepository();
//   //     parser = AnitubeGenreParser();
//   //     useCase = ReadGenres(repository, parser);
//   //   });

//   //   test("parsing genres with success", () async {
//   //     final file = File(GENRE_PAGE_MOCK_PATH);

//   //     final list = parser.parseHTML(file.readAsStringSync());
//   //     expect(list, isA<List<Genre>>());
//   //   });
//   // });
}
