import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/igenre_repository.dart';

abstract class IReadGenres {
  final IHTMLParser<List<Genre>> genrePageParser;

  IReadGenres(this.genrePageParser);
  Future<List<Genre>> getGenres();
}

class ReadGenres extends IReadGenres {
  final IGenreRepository repository;

  ReadGenres(
    this.repository,
    IHTMLParser<List<Genre>> parser,
  )   : assert(repository != null),
        super(parser);

  @override
  Future<List<Genre>> getGenres() async {
    final pageHTML = await repository.getGenres();
    return this.genrePageParser.parseHTML(pageHTML);
  }
}
