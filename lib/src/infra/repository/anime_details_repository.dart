import 'package:flutter/foundation.dart';
import '../../domain/irepository/ianime_details_repository.dart';
import '../../external/anitube/anitube_path.dart';
import '../../infra/data_source/page_fetcher.dart';

class AnimeDetailsRepository implements IAnimeDetailsRepository {
  final IHTMLPageFetcher dataSource;

  AnimeDetailsRepository({@required this.dataSource});

  @override
  Future<String> getAnimeDetails(String animeId) {
    return dataSource.downloadHTMLPage(url: AnitubePath.BASE_PATH + animeId);
  }
}
