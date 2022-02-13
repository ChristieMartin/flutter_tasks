import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rss_news/pages/favourite_news/favourite_news.dart';
import 'package:rss_news/pages/recent_news/cubit/recent_news_cubit.dart';
import 'package:rss_news/pages/recent_news/recent_news.dart';
import 'package:rss_news/service/rss_api.dart';
import 'package:rss_news/shared/constants.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const RecentNews(),
    const FavouriteNews()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecentNewsCubit>(
      create: (_) => RecentNewsCubit(RecentNewsFetcher()),
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.feed, size: 3.h), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.star, size: 3.h), label: "")
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: textColor.withOpacity(0.5),
          selectedItemColor: blueColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
