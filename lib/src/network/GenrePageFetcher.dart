// part of anitube_crawler_api;

// class GenrePageFetcher extends PageFetcher {
//   Future<String> getGenrePage({int timeout = PageFetcher.TIMEOUT_MS}) async {
//     String page = "";

//     try {
//       Response resp = await dio.get(AnitubePath.GENRES_PAGE,
//           options: Options(
//             sendTimeout: timeout,
//             receiveTimeout: timeout,
//             headers: { 'user-agent': UserAgents.generateAgent() }
//           ));
//       page = resp.data;
//     } on DioError catch (ex) {
//       print('GenrePageFetcher::getGenrePage $ex');
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
