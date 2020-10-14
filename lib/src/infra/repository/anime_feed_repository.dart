import '../../domain/entities/enums.dart';
import '../../domain/irepository/ianime_feed_repository.dart';
import '../../external/anitube/anitube_data_source.dart';
import '../../external/anitube/anitube_path.dart';

class AnimeFeedRepository implements IAnimeFeedRepository {
  final AnitubeDataSource dataSource;

  AnimeFeedRepository(this.dataSource);
  @override
  Future<String> getAnimesList({int pageNumber = 1, AnimeCC ccType}) async {
    int number = (pageNumber < 0) ? 0 : pageNumber;
    String url = ccType == AnimeCC.DUBBED
        ? AnitubePath.ANIME_LIST_PAGE_DUBBED
        : AnitubePath.ANIME_LIST_PAGE_LEGEND;
    url = url + number.toString();

    return this.dataSource.downloadHTMLPage(
          url: url,
        );
  }
}
