import 'package:anitube_crawler_api/src/domain/irepository/ianime_details_repository.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_path.dart';
import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';

class AnimeDetailsRepository implements IAnimeDetailsRepository {
  final IHTMLPageFetcher animeDetailsDataSource;

  AnimeDetailsRepository(this.animeDetailsDataSource);

  @override
  Future<String> getAnimeDetails(String animeId) {
    return animeDetailsDataSource.downloadHTMLPage(
        url: AnitubePath.BASE_PATH + animeId);
  }
}
