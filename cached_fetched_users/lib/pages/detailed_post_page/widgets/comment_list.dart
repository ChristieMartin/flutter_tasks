
import 'package:cached_fetched_users/pages/detailed_post_page/bloc/comments_bloc.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/comment.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/widgets/adding_comment_page.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CommentList extends StatefulWidget {
  const CommentList({super.key, required this.post});
  final Post post;
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsBloc()..add(LoadComments(widget.post.id)),
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (blocContext, state) {
          if (state is CommentsLoaded) {
            return Column(
              children: [
                ...state.comments.map(_commentsTile).toList(),
                _addCommentButton(blocContext),
                SizedBox(height: 10.h)
              ],
            );
          }
          if (state is CommentsLoadingFailed) {
            return Center(
                child: Text(
              state.error,
              style: TextStyle(color: AppColors.textColor1),
            ),);
          }
          return const Loading();
        },
      ),
    );
  }

  Future<void> _openCommentAddingPage(BuildContext blocContext) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.h),
        ),
        context: context,
        builder: (context) => AddingCommentPage(
            onSendComment: (comment) {
              BlocProvider.of<CommentsBloc>(blocContext).add(AddComment(comment));
            },
            post: widget.post,),);
  }

  Widget _addCommentButton(BuildContext blocContext) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      height: 6.h,
      child: TextButton(
          onPressed: () {
            _openCommentAddingPage(blocContext);
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.h),
                  side: BorderSide(
                      color: AppColors.blueColor, width: 0.5.w,),),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "write a comment",
                style: TextStyle(
                    color: AppColors.textColor3, fontSize: 16.sp,),
              ),
              Icon(Icons.send_rounded,
                  color: AppColors.blueColor, size: 3.h,)
            ],
          ),),
    );
  }

  Widget _commentsTile(Comment comment) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(2.h),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.name,
                style: TextStyle(
                    color: AppColors.textColor1, fontSize: 18.sp,),),
            Text(comment.email,
                style: TextStyle(
                    color: AppColors.textColor2, fontSize: 16.sp,),),
            const AppDivider(),
            Text(comment.body,
                style: TextStyle(
                    color: AppColors.textColor2, fontSize: 16.sp,),),
          ],
        ),);
  }

}
