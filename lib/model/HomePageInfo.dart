part of anitube_crawler_api;

class HomePageInfo {
  
  final List<AnimeItem> mostRecentAnimes;
  final List<AnimeItem> mostShowedAnimes;
  final List<EpisodeItem> latestEpisodes;
  final List<AnimeItem> dayReleases;

  HomePageInfo(this.mostRecentAnimes, this.mostShowedAnimes,
      this.latestEpisodes, this.dayReleases);
  
}