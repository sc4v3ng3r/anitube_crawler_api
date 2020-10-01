// part of anitube_crawler_api;

// class EpisodeVideoPageFetcher extends PageFetcher {
//   EpisodeVideoPageFetcher() : super();

//   Future<String> getVideoPage(String url,
//       {int timeout = PageFetcher.TIMEOUT_MS}) async {
//     String page;
//     try {
//       Response response = await dio.get(url,
//           options: Options(
//             receiveTimeout: timeout,
//             sendTimeout: timeout,
//             headers: { 'user-agent': UserAgents.generateAgent() }
//           ));

//       page = response.data;
//     } on DioError catch (ex) {
//       print("EpisodeVidePageFetcher::getVideoPage $ex");

//       switch (ex.type) {
//         case DioErrorType.SEND_TIMEOUT:
//         case DioErrorType.RECEIVE_TIMEOUT:
//         case DioErrorType.CONNECT_TIMEOUT:
//           throw TimeoutException(message: ex.message);
//           break;

//         // case DioErrorType.RESPONSE:
//         // case DioErrorType.CANCEL:
//         // case DioErrorType.DEFAULT:
//         default:
//           throw NetworkException(message: ex.message);
//           break;
//       }
//     }

//     return page;
//   }
// }
