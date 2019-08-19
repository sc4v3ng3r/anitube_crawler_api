part of anitube_crawler_api;

class EpisodeDetails {

  static const TITLE = "title";
  static const STREAM_URL = 'streamURL';
  static const PREVIOUS = "previous";
  static const NEXT = "next";
  static const DESCRIPTION = "description";

  final String title;
  final String streamingUrl;
  final String previousEpisodeId;
  final String nextEpisodeId;
  final String description;

  EpisodeDetails.fromJson( Map<String, dynamic> json ) :
      title = json[TITLE] ?? '',
      streamingUrl = json[STREAM_URL] ?? '',
      previousEpisodeId = json[PREVIOUS] ?? '',
      nextEpisodeId = json[NEXT] ?? '',
      description = json[DESCRIPTION] ?? '';

  @override
  String toString() =>
      "$TITLE: $title\n"
          "$STREAM_URL: $streamingUrl\n"
          "$NEXT: $nextEpisodeId\n"
          "$PREVIOUS : $previousEpisodeId\n"
          "$DESCRIPTION: $description";
}