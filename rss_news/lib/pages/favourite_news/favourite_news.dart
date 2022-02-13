import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_news/shared/list_provider.dart';
import 'package:rss_news/widgets/news_list.dart';

class FavouriteNews extends StatefulWidget {
  const FavouriteNews({Key? key}) : super(key: key);

  @override
  State<FavouriteNews> createState() => _FavouriteNewsState();
}

class _FavouriteNewsState extends State<FavouriteNews> {
  @override
  Widget build(BuildContext context) {
    ListProvider provider =
        Provider.of<ListProvider>(context, listen: true);
    return listBuilder(context, provider.favouriteNews, provider);
  }
}
