import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../infra/data_source/page_fetcher.dart';
import '../../domain/exceptions/CrawlerApiException.dart';
import '../../infra/data_source/UserAgents.dart';

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
      throw NetworkException(message: error.response.statusMessage);
    }
  }
}
