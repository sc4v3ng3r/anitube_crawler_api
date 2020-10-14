import '../../domain/irepository/iepisode_details_repository.dart';
import '../../external/anitube/anitube_path.dart';
import '../../infra/data_source/page_fetcher.dart';

class EpisodeRepository implements IEpisodeDetailsRepository {
  final IHTMLPageFetcher dataSource;

  EpisodeRepository(this.dataSource);
  @override
  Future<String> getEpisodeDetails(String episodeId) {
    return dataSource.downloadHTMLPage(
        url: AnitubePath.BASE_PATH + "/$episodeId");
  }
}
