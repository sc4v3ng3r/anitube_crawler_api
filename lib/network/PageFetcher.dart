part of anitube_crawler_api;

abstract class PageFetcher {
  /// default timeout of 8000 milliseconds
  static const TIMEOUT_MS = 8000;

  final Dio _dio;

  /// get dio instance.
  Dio get dio => _dio;

  /// TODO Add ignore certificates parameter in constructor future.
  PageFetcher() : _dio = Dio();
}
