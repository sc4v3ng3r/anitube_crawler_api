part of anitube_crawler_api;

class GenrePageParser {
  List<String> getGenresAvailable(String page) {
    var list = <String>[];

    if (page != null || page.isNotEmpty) {
      try {
        var body = parse(page);

      body
          .getElementsByClassName(_GenrePageNames.GENRE_CONTAINER)[0]
          .children
          .forEach((genreAnchor) {
        list.add(genreAnchor.text);
      });
      } 
      catch (ex){
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
