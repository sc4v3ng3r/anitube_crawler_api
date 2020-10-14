import 'package:anitube_crawler_api/src/domain/irepository/iepisode_details_repository.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_path.dart';
import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';

class EpisodeRepository implements IEpisodeDetailsRepository {
  final IHTMLPageFetcher dataSource;

  EpisodeRepository(this.dataSource);
  @override
  Future<String> getEpisodeDetails(String episodeId) {
    return dataSource.downloadHTMLPage(
        url: AnitubePath.BASE_PATH + "/$episodeId");
  }
}
