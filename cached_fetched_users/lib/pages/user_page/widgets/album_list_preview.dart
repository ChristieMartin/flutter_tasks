import 'package:auto_route/auto_route.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/router/router.gr.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AlbumListPreview extends StatelessWidget {
  const AlbumListPreview(
      {super.key, required this.user,  required this.albums, required this.albumPreviews,});

  final User user;
  final List<Album> albums;
  final List<Photo> albumPreviews;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.router.push(AlbumListRoute(user: user));
        
      },
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
          backgroundColor: AppColors.cardColor,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...albums
              .map(
                  (e) => _albumPreviewTile(e, albumPreviews[albums.indexOf(e)]),)
              .toList(),
          _moreButton()
        ],
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

  Widget _albumPreviewTile(Album album, Photo photo) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.play_arrow_rounded, color: AppColors.blueColor),
                SizedBox(
                  child: Text(album.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: AppColors.textColor1,),),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Center(
                child: SizedBox(
                    height: 12.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.h),
                      child: CachedNetworkImage(
                        imageUrl: photo.thumbnailUrl,
                        progressIndicatorBuilder: (_, __, progress) {
                          return const Loading();
                        },
                      ),
                    ),),)
          ],),
    );
  }
}
