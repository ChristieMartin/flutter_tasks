import 'package:flutter_test/flutter_test.dart';
import 'package:rss_news/shared/list_provider.dart';
import 'package:dart_rss/domain/rss_item.dart';

void main() {
  test(
      'addOrDeleteItem test: given the same item twice when addOrDeleteItem is called then the length of favouriteNews list is 0',
      () async {
    final listProvider = ListProvider();

    listProvider.addOrDeleteItem(const RssItem(link: "test"));

    expect(listProvider.favouriteNews.length, 1);

    listProvider.addOrDeleteItem(const RssItem(link: "test"));

    expect(listProvider.favouriteNews.length, 0);
  });

  test(
      'indexRssItem test: if no such item then indexRssItem gives -1, if more then index of the item',
      () async {
    final listProvider = ListProvider();
    const RssItem firstItem = RssItem(link: "item1");
    const RssItem secondItem = RssItem(link: "item2");

    expect(listProvider.indexRssItem(firstItem), -1);

    listProvider.addOrDeleteItem(firstItem);
    listProvider.addOrDeleteItem(secondItem);
    
    expect(listProvider.indexRssItem(secondItem), 1);
  });
}
