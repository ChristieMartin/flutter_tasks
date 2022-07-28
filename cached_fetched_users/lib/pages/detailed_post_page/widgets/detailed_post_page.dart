
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/widgets/comment_list.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class DetailedPostPage extends StatelessWidget {
  const DetailedPostPage({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: ListView(
            children: [
              Text(
                post.title,
                style: TextStyle(
                    color: AppColors.textColor1, fontSize: 20.sp,),
              ),
              SizedBox(height: 2.h),
              Text(
                post.body,
                style: TextStyle(
                    color: AppColors.textColor2, fontSize: 18.sp,),
              ),
              const AppDivider(),
              Text("comments:",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor1,),),
              CommentList(post: post)
            ],
          ),
        ),);
  }

  
}
