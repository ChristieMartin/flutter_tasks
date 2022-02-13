import 'package:dart_rss/domain/rss_feed.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:http/http.dart' as http;
import 'package:rss_news/service/exceptions.dart';

abstract class RssApi {
  static const String _baseUrl = 'https://lenta.ru/rss';

  Future<List<RssItem>> fetchNews();
}

class RecentNewsFetcher extends RssApi {
  final String _endPoint = "/news";

  @override
  Future<List<RssItem>> fetchNews() async {
    try {
      final http.Response response =
          await http.Client().get(Uri.parse(RssApi._baseUrl + _endPoint));
      if (response.statusCode == 200) {
        final List<RssItem> feed = RssFeed.parse(response.body).items;
        return feed;
      }
        throw RssException(response.statusCode.toString());
      } on http.ClientException {
        throw const RssException("ClientException");
      }
    }
  }
