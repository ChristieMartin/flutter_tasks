import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';

class ListProvider with ChangeNotifier {
  List<RssItem> favouriteNews = [];

  void addItem(RssItem item) {
    int index = indexRssItem(item);
    if (index != -1) {
      favouriteNews.removeAt(index);
      notifyListeners();
      return;
    }
    favouriteNews.add(item);
    notifyListeners();
  }

  int indexRssItem(RssItem item) {
    for (var i in favouriteNews) {
      if (i.link == item.link) return favouriteNews.indexOf(i);
    }
    return -1;
  }
}
