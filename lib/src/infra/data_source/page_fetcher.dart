abstract class IHTMLPageFetcher {
  Future<String> downloadHTMLPage({String url, int pageNumber});
}
