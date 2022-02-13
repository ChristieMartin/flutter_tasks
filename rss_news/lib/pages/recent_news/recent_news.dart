import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rss_news/pages/recent_news/cubit/recent_news_cubit.dart';
import 'package:rss_news/shared/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rss_news/shared/list_provider.dart';
import 'package:rss_news/widgets/news_list.dart';

class RecentNews extends StatelessWidget {
  const RecentNews({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const _RecentNews();
  }
}

class _RecentNews extends StatelessWidget {
  const _RecentNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentNewsCubit, RecentNewsState>(
      builder: (context, state) {
        if (state is RecentNewsInitial) {
          context.read<RecentNewsCubit>().loadNews();
        }
        if (state is RecentNewsError) {
          return Center(
              child: Text(state.error,
                  style: TextStyle(
                      color: redColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold)));
        }
        if (state is RecentNewsLoaded) {
          return RefreshIndicator(
              child: listBuilder(context, state.news, Provider.of<ListProvider>(context, listen: true)),
              onRefresh: () => context.read<RecentNewsCubit>().reloadNews());
        }
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          color: orangeColor,
          strokeWidth: 1.h,
        )));
      },
    );
  }
}
