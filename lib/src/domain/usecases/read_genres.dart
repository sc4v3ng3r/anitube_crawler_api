import '../../domain/entities/genre.dart';
import '../../domain/entities/parser/ihtml_parser.dart';
import '../../domain/irepository/igenre_repository.dart';

abstract class IReadGenres {
  Future<List<Genre>> getGenres();
}

class ReadGenres extends IReadGenres {
  final IGenreRepository repository;
  final IHTMLParser<List<Genre>> parser;

  ReadGenres({
    required this.repository,
    required this.parser,
  });

  @override
  Future<List<Genre>> getGenres() async {
    final pageHTML = await repository.getGenres();
    return this.parser.parseHTML(pageHTML);
  }
}
