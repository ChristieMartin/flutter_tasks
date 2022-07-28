

import 'package:auto_route/auto_route.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/router/router.gr.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class PostListPreview extends StatelessWidget {
  const PostListPreview({super.key, required this.user, required this.posts});
  final User user;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.router.push(PostListRoute(user: user));
      },
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
          backgroundColor: AppColors.cardColor,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...posts.map(_postPreviewTile).toList(), _moreButton()],
      ),
    );
  }

  Widget _moreButton() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.arrow_drop_down,
          color: AppColors.blueColor,
        ),
        Text("more",
            style:
                TextStyle(fontSize: 18.sp, color: AppColors.blueColor),),
        const Icon(
          Icons.arrow_drop_down,
          color: AppColors.blueColor,
        )
      ],
    ),);
  }

  Widget _postPreviewTile(Post post) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.play_arrow_rounded, color: AppColors.blueColor),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 65.w,
                    child: Text(post.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: AppColors.textColor1,),),
                  ),
                  Text(post.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.textColor2,),)
                ],
              ),
            )
          ],),
    );
  }
}
