part of anitube_crawler_api;

class EpisodeDetailsPageParser {

  Map<String, dynamic> parseEpisodeDetailsPage(String page){
    if (page == null || page.isEmpty)
      return {};

    Document html = parse(page);
    var body = html.getElementsByTagName('body')[0];

    var episodeTitle = body.getElementsByClassName( _EpisodePageNames.TITLE_CLASS)[0].text;
    print('Episode Title ${episodeTitle.trim()}');

    var videoUrl = body.getElementsByClassName(_EpisodePageNames.ACTION_DOWNLOAD_CLASS)
      [0].attributes['data-download'];
    print('Video Url: $videoUrl');

    // getting next and previous episodes
    var episodesContainer = body.getElementsByClassName(
        _EpisodePageNames.NEXT_PREV_CONTAINER)[0];

    var previous = episodesContainer.children[0];
    var nextElement = html.getElementById(_EpisodePageNames.ID_NEXT_EPISODE);
    var description = _extractDescription(body);

    return {
      EpisodeDetails.TITLE : episodeTitle,
      EpisodeDetails.STREAM_URL : videoUrl,
      EpisodeDetails.NEXT : _extractEpisodeId(nextElement),
      EpisodeDetails.PREVIOUS :_extractEpisodeId( previous ),
      EpisodeDetails.DESCRIPTION : description,
    };
  }

  String _extractEpisodeId(Element element) {
   if (element.attributes['class'] == _EpisodePageNames.LINK_DISABLE_CLASS){
     return '';
   }
   return element.attributes['href'].split('/')[3].trim();
  }

  String _extractDescription(Element body){
    return body.getElementsByClassName(_EpisodePageNames.DESCRIPTION_CONTAINER)
      [0]?.children[1]?.text ?? '';
  }
}

class _EpisodePageNames {
  static const ACTION_DOWNLOAD_CLASS = "actionDownload";
  static const TITLE_CLASS = "pagEpiTitulo";
  static const NEXT_PREV_CONTAINER = "pagEpiGroupControles";
  static const ID_NEXT_EPISODE = "proximoEPLink"; // anchor for next episode
  static const LINK_DISABLE_CLASS = "linkdisabled";
  static const DESCRIPTION_CONTAINER = "pagEpiDesc";

}