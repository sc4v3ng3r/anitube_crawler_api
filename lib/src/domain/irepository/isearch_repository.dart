import 'package:anitube_crawler_api/src/external/anitube/anitube_data_source.dart';
import 'package:anitube_crawler_api/src/external/anitube/anitube_path.dart';

abstract class ISearchRepository {
  Future<String> search(String search, {int pageNumber = 1});
}

class SearchRepository implements ISearchRepository {
  final AnitubeDataSource searchSource;

  SearchRepository(this.searchSource);

  @override
  Future<String> search(String search, {int pageNumber = 1}) => this
      .searchSource
      .downloadHTMLPage(url: _createSearchUrl(search, pageNumber));

  String _createSearchUrl(String searchQuery, int pageNumber) {
    if (pageNumber <= 0) pageNumber = 1;

    return AnitubePath.BASE_PATH +
        AnitubePath.PAGE +
        '$pageNumber/?s=${_handleQueryParam(searchQuery)}';
  }

  String _handleQueryParam(String param) {
    if (param.contains(' ')) {
      param = param.replaceAll(RegExp(r' '), '+');
    }

    return param;
  }
}
