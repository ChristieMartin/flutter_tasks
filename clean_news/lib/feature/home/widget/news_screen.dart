import 'package:clean_news/feature/everything/widget/everything_screen.dart';
import 'package:clean_news/feature/headlines/widget/headlines_screen.dart';
import 'package:clean_news/widget/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const TabBar(
              labelColor: AppColors.success,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: AppColors.success,
              tabs: [
                Tab(
                  icon: Icon(Icons.list_alt),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HeadlinesScreen(),
              EverythingScreen(),
            ],
          )),
    );
  }
}