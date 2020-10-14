import 'package:anitube_crawler_api/anitube_crawler_api.dart';

abstract class IHomeRepository {
  Future<String> getHomePage();
}
