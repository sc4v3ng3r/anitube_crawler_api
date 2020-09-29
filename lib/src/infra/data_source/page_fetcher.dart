abstract class IHTMLPageFetcher {
  final String url;

  IHTMLPageFetcher(this.url);
  Future<String> downloadHTMLPage({String url, int pageNumber});
}
