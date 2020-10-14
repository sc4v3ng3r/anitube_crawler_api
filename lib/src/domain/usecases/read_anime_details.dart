import 'package:meta/meta.dart';
import '../../domain/entities/AnimeDetails.dart';
import '../../domain/entities/parser/ihtml_parser.dart';
import '../../domain/irepository/ianime_details_repository.dart';

abstract class IReadAnimeDetails {
  Future<AnimeDetails> getAnimeDetails({@required String animeId});
}

class ReadAnimeDetails implements IReadAnimeDetails {
  final IHTMLParser<AnimeDetails> parser;
  final IAnimeDetailsRepository repository;

  ReadAnimeDetails({@required this.parser, @required this.repository});

  @override
  Future<AnimeDetails> getAnimeDetails({@required String animeId}) async {
    final html = await repository.getAnimeDetails(animeId);
    return parser.parseHTML(html);
  }
}
