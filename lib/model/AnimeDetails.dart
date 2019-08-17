part of anitube_crawler_api;

class AnimeDetails {

  static const TITLE = "titulo";
  static const AUTHOR = "Autor";
  static const FORMAT = "Formato";
  static const GENRE = "Gênero";
  static const DIRECTOR = "Diretor";
  static const STUDIO = "Estúdio";
  static const CC = "Tipo de Episódio";
  static const IMAGE_URL = "imageUrl";
  static const EPISODES_LIST = "episodios_lista";
  static const EPISODES_NUMBER = "episodios";
  static const DESCRIPTION = "sinopse";
  static const YEAR = "Ano";
  static const OVAS = "Ovas";
  static const MOVIES = "Filmes";

  final Map<String, dynamic> _data;
  final List<EpisodeItem> _episodes;

  String get title => _data[TITLE];
  
  String get author => _data[AUTHOR];
  
  String get format => _data[FORMAT];
  
  String get genre => _data[GENRE];
  
  String get director => _data[DIRECTOR];
  
  String get closedCaption => _data[CC];
  
  String get studio => _data[STUDIO];
  
  String get imageUrl => _data[IMAGE_URL];

  String get year => _data[YEAR];

  String get movies => _data[MOVIES];

  String get ovas => _data[OVAS];

  String get resume => _data[DESCRIPTION];

  String get episodesNumber => _data[EPISODES_NUMBER];

  List<EpisodeItem> get episodes => _episodes;


  AnimeDetails.fromJson(Map<String, dynamic> json) :
      _data = json,
      _episodes = List.from( json[EPISODES_LIST] ).map<EpisodeItem>(
              (epJson) => EpisodeItem.fromJson(epJson)
      ).toList();

  @override
  String toString() =>
      "$TITLE: $title\n"
          "$EPISODES_NUMBER: $episodesNumber\n"
          "$AUTHOR: $author\n"
          "$DIRECTOR: $director\n"
          "$STUDIO: $studio\n"
          "$FORMAT: $format\n"
          "$GENRE: $genre\n"
          "$CC: $closedCaption\n"
          "$YEAR: $year\n"
          "$IMAGE_URL: $imageUrl\n"
          "$DESCRIPTION: $resume\n"
          "$EPISODES_LIST: $episodes\n"
          "$MOVIES: $movies\n"
          "$OVAS: $ovas\n";
}