part of anitube_crawler_api;

class AnitubePath {

  static const BASE_PATH = "https://www.anitube.site/";
  static const PAGE = "page/";
  static const HOME_PAGE = BASE_PATH;
  static const GENRES_PAGE = BASE_PATH + "lista-de-generos/";

  static const ANIME_LIST_PAGE_DUBBED =
      BASE_PATH + "lista-de-animes-dublados/" + PAGE;

  static const ANIME_LIST_PAGE_LEGEND =
      BASE_PATH + "lista-de-animes-legendados/" + PAGE;

}