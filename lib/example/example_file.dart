import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions());

  final api = AniTubeApi(dio);

  try {
    final search = await api.search("shingeki");

    print("search results");
    search.animes.forEach((element) {
      print(element.title);
    });
  } on CrawlerApiException catch (ex) {
    print('${ex.errorType} -> ${ex.message}');
  }
}
