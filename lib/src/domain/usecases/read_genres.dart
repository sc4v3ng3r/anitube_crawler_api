import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/igenre_repository.dart';

abstract class IReadGenres {
  IReadGenres();
  Future<List<Genre>> getGenres();
}

class ReadGenres extends IReadGenres {
  final IGenreRepository repository;
  final IHTMLParser<List<Genre>> parser;
  ReadGenres(
    this.repository,
    this.parser,
  ) : assert(repository != null);

  @override
  Future<List<Genre>> getGenres() async {
    final pageHTML = await repository.getGenres();
    return this.parser.parseHTML(pageHTML);
  }
}
