import 'package:anitube_crawler_api/src/domain/entities/HomePageInfo.dart';
import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ihome_repository.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_path.dart';
import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';
import 'package:flutter/foundation.dart';

class HomePageRepository implements IHomeRepository {
  final IHTMLPageFetcher dataSource;
  final IHTMLParser<HomePageInfo> homePageParser;

  HomePageRepository(
      {@required this.dataSource, @required this.homePageParser});

  @override
  Future<HomePageInfo> getHomePage() async {
    final htmlPage =
        await this.dataSource.downloadHTMLPage(url: AnitubePath.HOME_PAGE);
    return homePageParser.parseHTML(htmlPage);
  }
}
