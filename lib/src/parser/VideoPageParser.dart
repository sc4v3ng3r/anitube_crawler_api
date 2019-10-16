part of anitube_crawler_api;

class VideoPageParser {
  static String getStreamUrl(String page) {
    try {
      Document html = parse(page);

      return html
          .getElementsByClassName('pagEpiAbas')[0]
          .getElementsByTagName('a')[0]
          .attributes['data-download'];
    } catch (ex) {
      print('Error in parsing process VideoPageParser::getStreamUrl\n $ex');
      throw ParserException(message: "Error parsing data.");
    }
  }
}
