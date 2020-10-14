import 'package:anitube_crawler_api/src/domain/entities/enums.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ianime_feed_repository.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_data_source.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_path.dart';

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
