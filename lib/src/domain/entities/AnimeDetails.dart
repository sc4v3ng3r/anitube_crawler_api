import 'EpisodeItem.dart';

// part of anitube_crawler_api;

/// This class holds read only details information
/// about a specific anime. All these information are
/// provided by animetube.site brazilian website and some of
/// them could be wrong or even not available.

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

  /// The data json map.
  final Map<String, dynamic> _data;

  /// The list of anime episode Items.
  final List<EpisodeItem> _episodes;

  /// The anime title
  String get title => _data[TITLE];

  /// The anime author
  String get author => _data[AUTHOR];

  String get format => _data[FORMAT];

  /// A String with the anime genres.
  String get genre => _data[GENRE];

  /// The anime director
  String get director => _data[DIRECTOR];

  /// Anime closed caption type. Can be dubbed OR legend.
  String get closedCaption => _data[CC];

  /// The a studio that produces this anime.
  String get studio => _data[STUDIO];

  /// Anime cover image Url.
  String get imageUrl => _data[IMAGE_URL];

  /// The anime year
  String get year => _data[YEAR];

  /// Anime movies Url
  String get movies => _data[MOVIES];

  String get ovas => _data[OVAS];

  /// The anime resume or synopsis
  String get resume => _data[DESCRIPTION];

  /// The number of episodes
  String get episodesNumber => _data[EPISODES_NUMBER];

  /// The list of episode available for this anime.
  List<EpisodeItem> get episodes => _episodes;

  AnimeDetails.fromJson(Map<String, dynamic> json)
      : _data = json,
        _episodes = List.from(json[EPISODES_LIST])
            .map<EpisodeItem>((epJson) => EpisodeItem.fromJson(epJson))
            .toList();

  @override
  String toString() => "$TITLE: $title\n"
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
