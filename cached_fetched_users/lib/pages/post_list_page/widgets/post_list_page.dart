import 'package:auto_route/auto_route.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/pages/post_list_page/bloc/post_list_bloc.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/router/router.gr.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key, required this.user});
  final User user;

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostListBloc()..add(LoadPosts(widget.user.id)),
      child: Scaffold(
        appBar: AppBar(title: Text("${widget.user.username}`s posts")),
        body: BlocBuilder<PostListBloc, PostListState>(
          builder: (context, state) {
            if (state is PostListLoaded) {
              return PostList(posts: state.posts);
            }
            if (state is PostListLoadingFailed) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyle(color: AppColors.textColor1),
                ),
              );
            }
            return const Loading();
          },
        ),
      ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({super.key, required this.posts});
  final List<Post> posts;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.posts
          .map(
            (p) => AppTextButton(
              context,
              firstText: p.title,
              secondText: p.body,
              onPressed: () {
                context.router.push(DetailedPostRoute(post: p));
              },
              firstTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColors.textColor1,
              ),
              secondTextStyle:
                  TextStyle(fontSize: 16.sp, color: AppColors.textColor2),
            ),
          )
          .toList(),
    );
  }
}
