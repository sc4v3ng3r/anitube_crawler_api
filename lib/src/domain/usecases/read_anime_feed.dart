import 'package:anitube_crawler_api/src/domain/entities/AnimeListPageInfo.dart';
import 'package:anitube_crawler_api/src/domain/entities/enums.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ianime_feed_repository.dart';
import 'package:meta/meta.dart';

abstract class IReadAnimeFeed {
  Future<AnimeListPageInfo> getAnimesFeed({int pageNumber = 1, AnimeCC ccType});
}

class ReadAnimeFeed implements IReadAnimeFeed {
  final IHTMLParser<AnimeListPageInfo> parser;
  final IAnimeFeedRepository feedRepository;

  ReadAnimeFeed({@required this.parser, @required this.feedRepository})
      : assert(parser != null || feedRepository != null);

  @override
  Future<AnimeListPageInfo> getAnimesFeed(
      {int pageNumber = 1, AnimeCC ccType = AnimeCC.LEGENDED}) async {
    final htmlPage = await feedRepository.getAnimesList(
        pageNumber: pageNumber <= 0 ? 1 : pageNumber,
        ccType: ccType ?? AnimeCC.LEGENDED);
    return parser.parseHTML(htmlPage);
  }
}
