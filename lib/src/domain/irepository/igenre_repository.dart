import 'package:anitube_crawler_api/src/domain/entities/genre.dart';

abstract class IGenreRepository {
  Future<String> getGenres();
}
