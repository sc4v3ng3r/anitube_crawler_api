import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:html/parser.dart';

class AnitubeGenreParser implements IHTMLParser<List<Genre>> {
  @override
  List<Genre> parseHTML(String html) {
    var list = <Genre>[];

    if (html != null || html.isNotEmpty) {
      try {
        var body = parse(html);

        body
            .getElementsByClassName(_GenrePageNames.GENRE_CONTAINER)[0]
            .children
            .forEach((genreAnchor) {
          list.add(Genre(genreAnchor.text));
        });
      } catch (ex) {
        print('GenrePageParser error while parsing.\n $ex');
        throw ParserException(message: "Error parsing genres data.");
      }
    }

    return list;
  }
}

class _GenrePageNames {
  static const GENRE_CONTAINER = "generosPagContainer";
}
