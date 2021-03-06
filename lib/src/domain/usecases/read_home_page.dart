import '../../domain/entities/parser/ihtml_parser.dart';
import '../../domain/irepository/ihome_repository.dart';
import '../entities/HomePageInfo.dart';
import 'package:meta/meta.dart';

abstract class IReadHomePage {
  Future<HomePageInfo> getHomePage();
}

class ReadHomePage implements IReadHomePage {
  final IHomeRepository homeRepository;
  final IHTMLParser<HomePageInfo> parser;
  ReadHomePage({@required this.parser, @required this.homeRepository})
      : assert(homeRepository != null || parser != null);

  @override
  Future<HomePageInfo> getHomePage() async {
    final htmlPage = await homeRepository.getHomePage();
    return parser.parseHTML(htmlPage);
  }
}
