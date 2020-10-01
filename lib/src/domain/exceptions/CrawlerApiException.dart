// part of anitube_crawler_api;

enum ErrorType {
  TIMEOUT,
  NETWORK,
  PARSER,
}

abstract class CrawlerApiException implements Exception {
  final String message;
  final ErrorType errorType;

  CrawlerApiException(this.errorType, {this.message});
}

class TimeoutException extends CrawlerApiException {
  TimeoutException({String message})
      : super(ErrorType.TIMEOUT, message: message);
}

class NetworkException extends CrawlerApiException {
  NetworkException({String message})
      : super(ErrorType.NETWORK, message: message);
}

class ParserException extends CrawlerApiException {
  ParserException({String message}) : super(ErrorType.PARSER, message: message);
}
