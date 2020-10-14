import 'package:meta/meta.dart';
import '../../domain/irepository/ihome_repository.dart';
import '../entities/HomePageInfo.dart';

abstract class IReadHomePage {
  Future<HomePageInfo> getHomePage();
}

class ReadHomePage implements IReadHomePage {
  final IHomeRepository homeRepository;
  ReadHomePage({@required this.homeRepository})
      : assert(homeRepository != null);

  @override
  Future<HomePageInfo> getHomePage() => homeRepository.getHomePage();
}
