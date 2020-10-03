import 'package:anitube_crawler_api/src/domain/entities/parser/ihtml_parser.dart';
import 'package:anitube_crawler_api/src/domain/irepository/ianime_details_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:anitube_crawler_api/src/domain/entities/AnimeDetails.dart';

abstract class IReadAnimeDetails {
  Future<AnimeDetails> getAnimeDetails({@required String animeId});
}

class ReadAnimeDetails implements IReadAnimeDetails {
  final IHTMLParser parser;
  final IAnimeDetailsRepository repository;

  ReadAnimeDetails({@required this.parser, @required this.repository});

  @override
  Future<AnimeDetails> getAnimeDetails({@required String animeId}) async {
    final html = await repository.getAnimeDetails(animeId);
    return parser.parseHTML(html);
  }
}
