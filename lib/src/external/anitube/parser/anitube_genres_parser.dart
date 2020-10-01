import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:html/parser.dart';

class AnitubeGenreParser implements IHTMLParser<List<Genre>> {
  @override
  List<Genre> parseHTML(String html) {
    if (html == null) throw ParserException(message: "null html data");
    try {
      var list = <Genre>[];
      var body = parse(html);

      body
          .getElementsByClassName(_GenrePageNames.GENRE_CONTAINER)[0]
          .children
          .forEach((genreAnchor) {
        list.add(Genre(genreAnchor.text));
      });
      return list;
    } catch (ex) {
      print('GenrePageParser error while parsing.\n $ex');
      throw ParserException(message: "Error parsing genres data.");
    }
  }
}

class _GenrePageNames {
  static const GENRE_CONTAINER = "generosPagContainer";
}
