import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_news/pages/recent_news/recent_news.dart';
import 'package:rss_news/pages/wrapper.dart';
import 'package:rss_news/shared/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rss_news/shared/list_provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'News',
      home: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return ChangeNotifierProvider( create: (context) => ListProvider(), child: const Wrapper());
        },
      ),
    );
  }
}
