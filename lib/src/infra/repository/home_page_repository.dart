import '../../domain/irepository/ihome_repository.dart';
import '../../external/anitube/anitube_path.dart';
import '../../infra/data_source/page_fetcher.dart';

class HomePageRepository implements IHomeRepository {
  final IHTMLPageFetcher dataSource;

  HomePageRepository(this.dataSource);

  @override
  Future<String> getHomePage() async {
    return this.dataSource.downloadHTMLPage(url: AnitubePath.HOME_PAGE);
  }
}
