part of anitube_crawler_api;


enum _HomePageAnimeCategory { MOST_SHOWED, MOST_RECENT, DAY_RELEASE }
class HomePageParser {

  List<Map<String, dynamic>> _parseAnimeItemContent(String page,
      {_HomePageAnimeCategory category = _HomePageAnimeCategory.MOST_SHOWED}){
    var dataList = < Map<String, dynamic> >[];
    Document pageDocument;

    if (page != null || page.isNotEmpty){
      pageDocument =  parse(page);
      var body = pageDocument.getElementsByTagName('body')[0];

      var containers = body.getElementsByClassName(_HomePageHtmlNames.ANI_CONTAINER);
//      print('Ani Containers ${containers.length}');

      // most recents aniItems
      var aniItemList = containers[ category.index ].children[1]
          .getElementsByClassName(_HomePageHtmlNames.ANI_ITEM);


      aniItemList.forEach( (aniItem){
        var pageLink = aniItem.children[0].attributes['href'];
        var title = aniItem.children[0].attributes['title'].split('–')[0];
        var id = pageLink.split('.site/')[1];

        id = id.substring(0, id.length-1);

        var itemImgDiv = aniItem.children[0]
            .getElementsByClassName(_HomePageHtmlNames.ANI_ITEM_IMG)[0];

        var imageUrl = itemImgDiv.getElementsByTagName('img')[0].attributes['src'];
        var cc = itemImgDiv.getElementsByClassName(_HomePageHtmlNames.ANI_CC)
          [0].text;

        dataList.add( {
          AnimeItem.ID : id,
          AnimeItem.TITLE : title,
          AnimeItem.PAGE_URL : pageLink,
          AnimeItem.IMAGE_URL : imageUrl,
          AnimeItem.CC : cc,
        } );

      }  );
    }

    return dataList;
  }

  
  /// Obtem os epsodios mais recentes
  List< Map<String, dynamic> > extractLatestEpisodes(String page){
    
    var dataList = < Map<String,dynamic> > [];
    
    var body = parse(page).getElementsByTagName('body')[0];
    
    var subContainer = body.getElementsByClassName(_HomePageHtmlNames.EPI_CONTAINER)[0]
      .getElementsByClassName(_HomePageHtmlNames.EPI_SUBCONTAINER)[0];

    //print('subcontainer children ${subContainer.children.length}');
    
    subContainer.children.forEach( (epiItem){
      var pageLink = epiItem.children[0].attributes['href'];
      var title = epiItem.children[0].attributes['title'];
      var id = pageLink.split('.site/')[1];

      id = id.substring(0, id.length-1);

      var itemImgDiv = epiItem.children[0]
          .getElementsByClassName(_HomePageHtmlNames.EPI_ITEM_IMG)[0];

      var imageUrl = itemImgDiv.getElementsByTagName('img')[0].attributes['src'];
      var cc = itemImgDiv.getElementsByClassName(_HomePageHtmlNames.EPI_CC)
      [0].text;


      dataList.add( {
        EpisodeItem.ID : id,
        EpisodeItem.TITLE : title,
        EpisodeItem.PAGE_URL : pageLink,
        EpisodeItem.IMAGE_URL : imageUrl,
        EpisodeItem.CC : cc,
      } );
    } );
    
    return dataList;
  }

  /// Obtem os animes mais visualizados
  List< Map<String, dynamic> > extractMostShowedAnimes(String page) =>
    _parseAnimeItemContent(page, category: _HomePageAnimeCategory.MOST_SHOWED);
  
  /// obtem os animes mais recentes
  List< Map<String, dynamic> > extractRecentAnimes(String page) =>
      _parseAnimeItemContent(page, category: _HomePageAnimeCategory.MOST_RECENT);

  List< Map<String,dynamic> > extractDayRelease(String page) =>
      _parseAnimeItemContent(page, category: _HomePageAnimeCategory.DAY_RELEASE);
}


class _HomePageHtmlNames {

  static const ANI_CONTAINER = "aniContainer"; // class
  static const MAIN_CAROUSEL = "main-carousel"; // class
  static const FLICK_SLIDER = "flickity-slider"; // class
  static const FLICKITY_VIEWPORT = "flickity-viewport";// class
  static const ANI_ITEM = "aniItem"; // class
  static const ANI_ITEM_IMG = "aniItemImg";
  static const EPI_ITEM_IMG = "epiItemImg";
  static const ANI_CC = "aniCC";
  static const EPI_CC = "epiCC";
  static const EPI_CONTAINER = "epiContainer";
  static const EPI_SUBCONTAINER = "epiSubContainer";

}