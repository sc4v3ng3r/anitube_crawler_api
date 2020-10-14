import 'package:anitube_crawler_api/src/infra/data_source/page_fetcher.dart';
import 'package:anitube_crawler_api/src/network/UserAgents.dart';
import 'package:dio/dio.dart';
import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
import 'package:meta/meta.dart';

class AnitubeDataSource extends IHTMLPageFetcher {
  final Dio httpClient;

  AnitubeDataSource(this.httpClient, {String url}) {
    httpClient.interceptors
        .add(InterceptorsWrapper(onRequest: (requestOptions) {
      requestOptions.headers['user-agent'] = UserAgents.generateAgent();
    }));
  }

  @override
  Future<String> downloadHTMLPage({
    @required String url,
  }) async {
    try {
      final response = await httpClient.get(url);
      return response.data;
    } on DioError catch (error) {
      print(error);
      throw NetworkException(message: error.response.statusMessage);
    }
  }
}
