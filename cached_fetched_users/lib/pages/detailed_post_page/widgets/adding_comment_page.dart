import 'dart:math';

import 'package:cached_fetched_users/pages/detailed_post_page/models/comment.dart';
import 'package:cached_fetched_users/pages/detailed_post_page/models/post.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddingCommentPage extends StatefulWidget {
  const AddingCommentPage({super.key, required this.onSendComment, required this.post});
  final Post post;
  final void Function(Comment) onSendComment;
  @override
  State<AddingCommentPage> createState() => _AddingCommentPageState();
}

class _AddingCommentPageState extends State<AddingCommentPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      builder: (context, controller) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.h), topRight: Radius.circular(2.h),),
          child: SizedBox(
            //height: 70.h,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: const Text("write a comment"),
                ),
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView(
                    controller: controller,
                    children: [
                      _textField("name", "enter your name", _nameController),
                      _textField("email", "enter your email", _emailController),
                      _textField("text", "enter your comment", _bodyController),
                      _sendButton()
                    ],
                  ),
                ),),
          ),
        );
      },
    );
  }

  Widget _sendButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: TextButton(
        onPressed: () {
          final bool allFieldAreNotEmpty = _nameController.text.trim() != "" && _emailController.text.trim() != "" && _bodyController.text.trim() != "";
          if (allFieldAreNotEmpty) {
            final Comment comment = Comment(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              body: _bodyController.text.trim(),
              id: Random().nextInt(1000) + 1000,
              postId: widget.post.id,
            );
            widget.onSendComment(comment);
            Navigator.pop(context);
            
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.h)),
          backgroundColor: AppColors.blueColor,
        ),
        child: Center(
          child: Text("send", style:TextStyle(color: AppColors.textColor1, fontSize: 18.sp)),
        ),
      ),
    );
  }

  Widget _textField(
      String upperText, String hintText, TextEditingController controller,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("  $upperText:",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor1,),),
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          child: TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 18.sp, color: AppColors.textColor1),
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 18.sp, color: AppColors.textColor2),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5.w,
                      color: AppColors.blueColor,
                    ),
                    borderRadius: BorderRadius.circular(2.h),),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5.w,
                      color: AppColors.blueColor,
                    ),
                    borderRadius: BorderRadius.circular(2.h),),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5.w,
                      color: AppColors.textColor3,
                    ),
                    borderRadius: BorderRadius.circular(2.h),),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5.w,
                      color: AppColors.blueColor,
                    ),
                    borderRadius: BorderRadius.circular(2.h),),),
          ),
        ),
      ],
    );
  }
}
