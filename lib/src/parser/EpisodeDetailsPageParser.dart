// // part of anitube_crawler_api;

// import 'package:anitube_crawler_api/src/domain/entities/EpisodeDetails.dart';
// import 'package:anitube_crawler_api/src/domain/exceptions/CrawlerApiException.dart';
// import 'package:html/dom.dart';
// import 'package:html/parser.dart';

// class EpisodeDetailsPageParser {
//   Map<String, dynamic> parseEpisodeDetailsPage(String page) {
//     if (page == null || page.isEmpty) return {};

//     try {
//       Document html = parse(page);
//       var body = html.getElementsByTagName('body')[0];

//       var videoSources = html.getElementsByTagName('source');

//       var episodeTitle =
//           body.getElementsByClassName(_EpisodePageNames.TITLE_CLASS)[0].text;
//       //print('Episode Title ${episodeTitle.trim()}');

//       // var div = html.getElementById(_EpisodePageNames.DIV_P1_ID);
//       var videoUrl;

//       if (videoSources.isNotEmpty)
//         videoUrl =  videoSources[0].attributes['src'];
//       else {
//         videoUrl = _extractVideoUrlFromJScode(html);
//       }

//       if (videoUrl == null || videoUrl.isEmpty){
//         videoUrl = body.getElementsByClassName(_EpisodePageNames.ACTION_DOWNLOAD_CLASS)
//           [0].attributes['data-download'] + '&type=1';
//       }

//       else {
//         // grant only "https://domainlink" string format.

//       }

//       //print('Video Url: $videoUrl');

//       // getting next and previous episodes
//       var episodesContainer =
//           body.getElementsByClassName(_EpisodePageNames.NEXT_PREV_CONTAINER)[0];

//       var previous = episodesContainer.children[0];
//       var animeId = episodesContainer.children[1].attributes['href'].split('/')[3].trim();
//       var nextElement = html.getElementById(_EpisodePageNames.ID_NEXT_EPISODE);

//       var description = _extractDescription(body);

//       return {
//         EpisodeDetails.TITLE: episodeTitle,
//         EpisodeDetails.STREAM_URL: videoUrl,
//         EpisodeDetails.NEXT: _extractEpisodeId(nextElement),
//         EpisodeDetails.PREVIOUS: _extractEpisodeId(previous),
//         EpisodeDetails.DESCRIPTION: description,
//         EpisodeDetails.ANIME_ID: animeId,
//         EpisodeDetails.REFERER: videoUrl,
//       };
//     } catch (ex) {
//       print(
//           'Error in parsing process EpisodeDetailsPageParser::parseEpisodeDetailsPage\n $ex');
//       throw ParserException(message: "Error parsing data.");
//     }
//   }

//   String _extractEpisodeId(Element element) {
//     if (element.attributes['class'] == _EpisodePageNames.LINK_DISABLE_CLASS) {
//       return '';
//     }
//     return element.attributes['href'].split('/')[3].trim();
//   }

//   String _extractDescription(Element body) {
//     return body
//             .getElementsByClassName(_EpisodePageNames.DESCRIPTION_CONTAINER)[0]
//             ?.children[1]
//             ?.text ??
//         '';
//   }

//   String _extractVideoUrlFromJScode(Document html) {
//     var jsDiv = html.getElementById('video')
//     .getElementsByTagName('script')[5];

//     const URL_REGEXP = r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._,\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_,\+.~#?&\/=]*)?";
//     // const regex = ' /[file\:\ ]/';

//     var regExp = RegExp(URL_REGEXP,);
//     var data = regExp.allMatches(jsDiv.innerHtml,);
//       final urls = data
//         .map((urlMatch) => jsDiv.innerHtml.substring(urlMatch.start, urlMatch.end + 1 ))
//         .toList();

//     var link = urls[1].replaceAll('"' , '');
//     link = link.replaceAll( '\'' , '');
//     if (link.startsWith("le: ") )
//       link = link.substring(4, );

//     print('The link is $link');
//     return link;
//   }

//   // String _extractVideoPageUrl(Element element) =>
//   //     element.getElementsByTagName('a')[0].attributes['href'];
// }

// class _EpisodePageNames {
//   static const ACTION_DOWNLOAD_CLASS = "actionDownload";
//   static const TITLE_CLASS = "pagEpiTitulo";
//   static const NEXT_PREV_CONTAINER = "pagEpiGroupControles";
//   static const ID_NEXT_EPISODE = "proximoEPLink"; // anchor for next episode
//   static const LINK_DISABLE_CLASS = "linkdisabled";
//   static const DESCRIPTION_CONTAINER = "pagEpiDesc";
//   static const DIV_P1_ID = "p1";
//   static const PAGE_EPI_ABAS_CONTAINER = "pagEpiAbasContainer";
// }
