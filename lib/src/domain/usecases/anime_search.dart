import 'package:anitube_crawler_api/src/domain/entities/AnimeListPageInfo.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/isearch_repository.dart';

abstract class IAnimeSearch {
  Future<AnimeListPageInfo> search(String search, {int pageNumber = 1});
}

class AnimeSearch implements IAnimeSearch {
  final IHTMLParser<AnimeListPageInfo> searchParser;
  final ISearchRepository searchRepository;

  AnimeSearch(this.searchParser, this.searchRepository);

  @override
  Future<AnimeListPageInfo> search(String search, {int pageNumber = 1}) async {
    final page =
        await this.searchRepository.search(search, pageNumber: pageNumber);
    return searchParser.parseHTML(
      page,
    );
  }
}
