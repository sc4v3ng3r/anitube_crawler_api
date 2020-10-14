import '../../domain/entities/AnimeListPageInfo.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/parser/ihtml_parser.dart';
import '../../domain/irepository/ianime_feed_repository.dart';
import 'package:meta/meta.dart';

abstract class IReadAnimeFeed {
  Future<AnimeListPageInfo> getAnimesFeed(
      {int pageNumber = 1, String startsWith, AnimeCC ccType});
}

class ReadAnimeFeed implements IReadAnimeFeed {
  final IHTMLParser<AnimeListPageInfo> parser;
  final IAnimeFeedRepository feedRepository;

  ReadAnimeFeed({@required this.parser, @required this.feedRepository})
      : assert(parser != null || feedRepository != null);

  @override
  Future<AnimeListPageInfo> getAnimesFeed(
      {int pageNumber = 1,
      String startsWith,
      AnimeCC ccType = AnimeCC.LEGENDED}) async {
    final htmlPage = await feedRepository.getAnimesList(
        startsWith: startsWith,
        pageNumber: pageNumber <= 0 ? 1 : pageNumber,
        ccType: ccType ?? AnimeCC.LEGENDED);
    return parser.parseHTML(htmlPage);
  }
}
