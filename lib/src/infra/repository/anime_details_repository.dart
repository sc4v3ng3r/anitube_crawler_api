import 'package:anitube_crawler_api/src/domain/irepository/ianime_details_repository.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_path.dart';
import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';
import 'package:flutter/foundation.dart';

class AnimeDetailsRepository implements IAnimeDetailsRepository {
  final IHTMLPageFetcher dataSource;

  AnimeDetailsRepository({@required this.dataSource});

  @override
  Future<String> getAnimeDetails(String animeId) {
    return dataSource.downloadHTMLPage(url: AnitubePath.BASE_PATH + animeId);
  }
}
