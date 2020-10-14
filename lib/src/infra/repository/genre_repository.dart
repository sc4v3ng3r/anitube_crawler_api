import '../../domain/irepository/igenre_repository.dart';
import '../../external/anitube/anitube_path.dart';
import '../../infra/data_source/page_fetcher.dart';

class GenreRepository implements IGenreRepository {
  final IHTMLPageFetcher pageFetcher;

  GenreRepository(this.pageFetcher);
  @override
  Future<String> getGenres() {
    return pageFetcher.downloadHTMLPage(url: AnitubePath.GENRES_PAGE);
  }
}
