import 'package:flutter/foundation.dart';
import '../../domain/entities/HomePageInfo.dart';
import '../../domain/entities/parser/ihtml_parser.dart';
import '../../domain/irepository/ihome_repository.dart';
import '../../external/anitube/anitube_path.dart';
import '../../infra/data_source/page_fetcher.dart';

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
