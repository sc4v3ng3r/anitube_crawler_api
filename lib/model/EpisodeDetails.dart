part of anitube_crawler_api;

/// This class holds read only info about an episode. All
/// the information are provided by animetube.site brazilian website
/// and some of them infos can be wrong or even unavailable.
class EpisodeDetails {

  static const TITLE = "title";
  static const STREAM_URL = 'streamURL';
  static const PREVIOUS = "previous";
  static const NEXT = "next";
  static const DESCRIPTION = "description";

  /// The episode title.
  final String title;

  /// Episode video stream url.
  final String streamingUrl;

  /// Nrevious episode Id if existent.
  final String previousEpisodeId;
  /// Next episode Id if existent.
  final String nextEpisodeId;

  /// Episode description
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