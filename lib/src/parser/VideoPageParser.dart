part of anitube_crawler_api;


@deprecated 
class VideoPageParser {
  
  
  static String getStreamUrl(String page) {
    try {
      const URL_REGEXP = r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?"; 

      Document html = parse(page);
      var regExp = RegExp(URL_REGEXP);

      var videoTags = html.getElementById('p1');
      var jsData = videoTags.getElementsByTagName('script');
      var data = regExp.allMatches(jsData[0].innerHtml.trim());
      final urls = data
        .map((urlMatch) => jsData[0].innerHtml.substring(urlMatch.start, urlMatch.end + 1 ))
        .toList();
      print(urls);
      
      var link = urls[2].replaceAll('"' , '');
      return link;

      // return html
      //     .getElementsByClassName('pagEpiAbas')[0]
      //     .getElementsByTagName('a')[0]
      //     .attributes['data-download'];
    } catch (ex) {
      print('Error in parsing process VideoPageParser::getStreamUrl\n $ex');
      throw ParserException(message: "Error parsing data.");
    }
  }
}
