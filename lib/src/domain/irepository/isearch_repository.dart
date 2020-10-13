abstract class ISearchRepository {
  Future<String> search(String search, {int pageNumber = 1});
}
