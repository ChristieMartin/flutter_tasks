import 'package:cached_fetched_users/pages/user_page/bloc/user_preview_bloc.dart';
import 'package:cached_fetched_users/pages/user_page/models/company.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/pages/user_page/widgets/album_list_preview.dart';
import 'package:cached_fetched_users/pages/user_page/widgets/post_list_preview.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.user});
  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserPreviewBloc()..add(LoadUserPreview(widget.user.id)),
      child: Scaffold(
          appBar: AppBar(title: Text(widget.user.username)),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: SingleChildScrollView(
              child: BlocBuilder<UserPreviewBloc, UserPreviewState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _userProperty("name", widget.user.name),
                      _userProperty("email", widget.user.email),
                      _userProperty("phone", widget.user.phone),
                      _userProperty("website", widget.user.website),
                      _userProperty("working at", ""),
                      _companyCard(widget.user.company),
                      _userProperty("address",
                          "${widget.user.address.city}, ${widget.user.address.street},\n${widget.user.address.suite} ${widget.user.address.zipcode}",),
                      const AppDivider(),

                      if (state is UserPreviewLoadingFailed) Center(child: Text(state.error, style: TextStyle(color: AppColors.textColor1),)),

                      _userProperty("posts", ""),
                      if (state is UserPreviewLoading) const Loading(),
                      if (state is UserPreviewPostsAndAlbumsLoaded) PostListPreview(posts: state.posts, user: widget.user),

                      _userProperty("albums", ""),
                      if (state is UserPreviewLoading) const Loading(),
                      if (state is UserPreviewPostsAndAlbumsLoaded) AlbumListPreview(user: widget.user, albums: state.albums, albumPreviews: state.albumPreviews),
                      SizedBox(height: 10.h,)

                    ],
                  );
                },
              ),
            ),
          ),),
    );
  }

  Widget _companyCard(Company company) {
    return Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(2.h),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        child: Column(
          children: [
            Text(company.name,
                style: TextStyle(color: AppColors.textColor1),),
            Text(company.bs,
                style: TextStyle(color: AppColors.textColor2),),
            Text(company.catchPhrase,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textColor3,),),
          ],
        ),);
  }

  Widget _userProperty(String firstText, String secondText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(children: [
        SizedBox(
          width: 2.w,
        ),
        Text("$firstText:",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor1,),),
        SizedBox(
          width: 2.w,
        ),
        SizedBox(
          width: 55.w,
          child: Text(secondText,
              style: TextStyle(
                  fontSize: 16.sp, color: AppColors.textColor2,),),
        ),
      ],),
    );
  }
}
