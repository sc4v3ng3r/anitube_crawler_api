import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';
import 'package:anitube_crawler_api/src/network/UserAgents.dart';
import 'package:dio/dio.dart';

class AnitubeDataSource implements IHTMLPageFetcher {
  final Dio httpClient;

  AnitubeDataSource(this.httpClient) {
    httpClient.interceptors
        .add(InterceptorsWrapper(onRequest: (requestOptions) {
      requestOptions.headers['user-agent'] = UserAgents.generateAgent();
    }));
  }
  @override
  String get url => AnitubePath.GENRES_PAGE;

  @override
  Future<String> downloadHTMLPage({String url, int pageNumber}) async {
    try {
      final response = await httpClient.get(url ?? this.url);
      return response.data;
    } on DioError catch (error) {
      throw NetworkException(message: error.response.statusMessage);
    }
  }
}
