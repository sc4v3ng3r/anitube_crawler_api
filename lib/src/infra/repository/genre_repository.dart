import 'package:anitube_crawler_api/src/domain/entities/genre.dart';
import 'package:anitube_crawler_api/src/domain/irepository/igenre_repository.dart';
import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';

class GenreRepository implements IGenreRepository {
  final IHTMLPageFetcher pageFetcher;

  GenreRepository(this.pageFetcher);
  @override
  Future<String> getGenres() {
    return pageFetcher.downloadHTMLPage();
  }
}
