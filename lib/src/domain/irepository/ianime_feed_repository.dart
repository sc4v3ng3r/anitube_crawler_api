import 'package:anitube_crawler_api/src/domain/entities/enums.dart';

abstract class IAnimeFeedRepository {
  Future<String> getAnimesList(
      {int pageNumber = 1, String startsWith, AnimeCC ccType});
}
