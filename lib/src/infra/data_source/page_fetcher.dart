import 'package:meta/meta.dart';

abstract class IHTMLPageFetcher {
  Future<String> downloadHTMLPage({
    @required String url,
  });
}
