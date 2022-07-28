import 'package:auto_route/auto_route.dart';
import 'package:cached_fetched_users/pages/album_list_page/bloc/album_list_bloc.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/router/router.gr.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key, required this.user});
  final User user;

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumListBloc()..add(LoadAlbumList(widget.user.id)),
      child: Scaffold(
        appBar: AppBar(title: Text("${widget.user.username}`s albums")),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: BlocBuilder<AlbumListBloc, AlbumListState>(
            builder: (context, state) {
              if (state is AlbumListLoaded) {
                return AlbumList(
                  albums: state.albums,
                  albumPreviews: state.albumPreviews,
                );
              }
              if (state is AlbumListLoadingFailed) {
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
      ),
    );
  }
}

class AlbumList extends StatefulWidget {
  const AlbumList(
      {super.key, required this.albums, required this.albumPreviews});
  final List<Album> albums;
  final List<Photo>? albumPreviews;

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.albums.length,
      itemBuilder: (context, index) => _albumListItem(widget.albums[index],
          widget.albumPreviews != null ? widget.albumPreviews![index] : null,),
    );
  }

  Widget _albumListItem(Album album, Photo? photo) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: TextButton(
        onPressed: () {
          context.router.push(DetailedAlbumRoute(album: album));
        },
        style: TextButton.styleFrom(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 75.w,
                  child: Text(
                    album.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: AppColors.textColor1,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 12.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.h),
                      child: photo != null
                          ? CachedNetworkImage(
                              imageUrl: photo.thumbnailUrl,
                              progressIndicatorBuilder: (_, __, progress) {
                                return const Loading();
                              },
                            )
                          : const Loading(),
                    ),
                  ),
                )
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 3.h,
              color: AppColors.textColor2,
            )
          ],
        ),
      ),
    );
  }
}
