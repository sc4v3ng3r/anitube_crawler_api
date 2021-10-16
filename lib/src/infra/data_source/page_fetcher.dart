abstract class IHTMLPageFetcher {
  Future<String> downloadHTMLPage({
    required String url,
  });
}
