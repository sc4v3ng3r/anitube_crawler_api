part of anitube_crawler_api;

/// This class holds read only information about the anitube.site website
/// home page. These infos are the most recent animes,
/// the animes more visualized, the latest episodes and the
/// releases of the day.
class HomePageInfo {

  /// The Most recent animes.
  final List<AnimeItem> mostRecentAnimes;

  /// The animes with more visualization.
  final List<AnimeItem> mostShowedAnimes;

  /// The most recent episodes.
  final List<EpisodeItem> latestEpisodes;

  /// The releases of the day.
  final List<AnimeItem> dayReleases;

  HomePageInfo(this.mostRecentAnimes, this.mostShowedAnimes,
      this.latestEpisodes, this.dayReleases);
  
}