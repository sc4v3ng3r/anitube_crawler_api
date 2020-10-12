import 'package:anitube_crawler_api/anitube_crawler_api.dart';

import '../entities/HomePageInfo.dart';

abstract class IHomeRepository {
  Future<HomePageInfo> getHomePage();
}
