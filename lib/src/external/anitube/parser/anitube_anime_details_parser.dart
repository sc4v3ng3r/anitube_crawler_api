import 'package:html/dom.dart';
import 'package:html/parser.dart';
import '../../../domain/entities/Item.dart';
import '../../../domain/exceptions/CrawlerApiException.dart';
import '../../../domain/entities/AnimeDetails.dart';
import '../../../domain/entities/parser/ihtml_parser.dart';
import '../anitube_path.dart';

class AnitubeAnimeDetailsParser implements IHTMLParser<AnimeDetails> {
  @override
  parseHTML(String? html) {
    if (html == null) throw ParserException(message: "Null html data");

    try {
      Document doc = parse(html);
      var body = doc.getElementsByTagName('body')[0];

      var animeTitle = _parseAnimeTitle(body);
      var imageUrl = doc
          .getElementById(_AnimeDetailsPageNames.ID_ANIME_COVER)
          ?.children[0]
          .attributes['src'];

      var resume =
          doc.getElementById(_AnimeDetailsPageNames.ID_RESUME)?.text ?? '';

      var infoBox = body
          .getElementsByClassName(_AnimeDetailsPageNames.ANIME_BOX_ABOUT_IT)[0];

      var infoMap = _parseAnimeInfo(infoBox);

      var container = body.getElementsByClassName(
          _AnimeDetailsPageNames.ANIME_EPISODES_CONTAINER);

      var episodesItemList;

      // The first container is the episode containers
      // some titles has OVAS and MOVIES containers too.
      // but for now let's get only the episodes.
      if (container.isNotEmpty) {
        episodesItemList =
            container[0].children.map<Map<String, dynamic>>((anchor) {
          var id = anchor.attributes['href']?.split(AnitubePath.BASE_PATH).last;
          return {
            Item.ID: id?.substring(0, id.length - 1),
            Item.TITLE: anchor.attributes['title'],
            Item.PAGE_URL: anchor.attributes['href'],
            Item.IMAGE_URL: imageUrl,
            Item.CC: infoMap[AnimeDetails.CC] ?? '',
          };
        }).toList();
      } else
        episodesItemList = [];
      return AnimeDetails.fromJson({
        AnimeDetails.TITLE: animeTitle,
        AnimeDetails.IMAGE_URL: imageUrl,
        AnimeDetails.DESCRIPTION: resume,
        AnimeDetails.EPISODES_LIST: episodesItemList,
        AnimeDetails.EPISODES_NUMBER: episodesItemList?.length.toString() ?? "",
        AnimeDetails.FORMAT: infoMap[AnimeDetails.FORMAT] ?? "",
        AnimeDetails.DIRECTOR: infoMap[AnimeDetails.DIRECTOR] ?? "",
        AnimeDetails.STUDIO: infoMap[AnimeDetails.STUDIO] ?? "",
        AnimeDetails.GENRE: infoMap[AnimeDetails.GENRE] ?? "",
        AnimeDetails.AUTHOR: infoMap[AnimeDetails.AUTHOR] ?? "",
        AnimeDetails.CC: infoMap[AnimeDetails.CC] ?? "",
        AnimeDetails.YEAR: infoMap[AnimeDetails.YEAR] ?? "",
        AnimeDetails.MOVIES: infoMap[AnimeDetails.MOVIES] ?? "",
        AnimeDetails.OVAS: infoMap[AnimeDetails.OVAS] ?? "",
      });
    } catch (ex) {
      print("AnimeDetailsPageParser\n$ex");
      throw ParserException(message: "Error parsing anime details page.");
    }
  }

  String _parseAnimeTitle(Element body) {
    return body
        .getElementsByClassName(_AnimeDetailsPageNames.TITLE_ELEMENT)[0]
        .getElementsByTagName('h1')[0]
        .text;
  }

  Map<String, dynamic> _parseAnimeInfo(Element infoContainer) {
    var infoChildren = infoContainer
        .getElementsByClassName(_AnimeDetailsPageNames.ANIME_BOX_INFO);

    Map<String, dynamic> map = {};

    infoChildren.forEach((element) {
      var data = element.text.split(':');
      map.putIfAbsent(data[0], () => data[1]);
    });

    return map;
  }
}

class _AnimeDetailsPageNames {
  static const TITLE_ELEMENT = "pagAniTitulo";
  static const ID_ANIME_COVER = "capaAnime";
  static const ID_RESUME = "sinopse2";

  static const ANIME_BOX_ABOUT_IT = "boxAnimeSobre";
  static const ANIME_BOX_INFO = "boxAnimeSobreLinha";
  static const ANIME_VIDEO_LIST = "pagAniLista";
  static const ANIME_EPISODES_CONTAINER = "pagAniListaContainer";
}
