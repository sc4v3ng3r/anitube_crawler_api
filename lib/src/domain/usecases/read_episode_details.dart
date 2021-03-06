import '../../domain/entities/EpisodeDetails.dart';
import '../../domain/entities/parser/ihtml_parser.dart';
import '../../domain/irepository/iepisode_details_repository.dart';
import 'package:meta/meta.dart';

abstract class IReadEpisodeDetails {
  Future<EpisodeDetails> getEpisodeDetails(final String episodeId);
}

class ReadEpisodeDetails implements IReadEpisodeDetails {
  final IHTMLParser<EpisodeDetails> parser;
  final IEpisodeDetailsRepository repository;

  ReadEpisodeDetails({@required this.parser, @required this.repository})
      : assert(parser != null || repository != null);

  @override
  Future<EpisodeDetails> getEpisodeDetails(String episodeId) async {
    final html = await repository.getEpisodeDetails(episodeId);
    return parser.parseHTML(html);
  }
}
