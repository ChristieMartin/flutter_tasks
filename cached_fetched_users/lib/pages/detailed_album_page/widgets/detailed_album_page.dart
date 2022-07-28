
import 'package:cached_fetched_users/pages/detailed_album_page/bloc/album_bloc.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/album.dart';
import 'package:cached_fetched_users/pages/detailed_album_page/models/photo.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class DetailedAlbumPage extends StatefulWidget {
  const DetailedAlbumPage({super.key, required this.album});
  final Album album;

  @override
  State<DetailedAlbumPage> createState() => _DetailedAlbumPageState();
}

class _DetailedAlbumPageState extends State<DetailedAlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Center(
                  child: Text(widget.album.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColor1, fontSize: 20.sp,),),),
              SizedBox(height: 1.h),
              AlbumPhotos(album: widget.album)
            ],
          ),
        ),);
  }
}

class AlbumPhotos extends StatefulWidget {
  const AlbumPhotos({super.key, required this.album});
  final Album album;

  @override
  State<AlbumPhotos> createState() => _AlbumPhotosState();
}

class _AlbumPhotosState extends State<AlbumPhotos> {


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(2.h),),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: BlocProvider(
          create: (context) => AlbumBloc()..add(LoadAlbum(widget.album)),
          child: BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {
            if (state is AlbumLoaded) {
              return PhotoCarousel(photos: state.albumPhoto);
            }
            if (state is AlbumLoadingFailed) {
              return Center(
                  child: Text(
                state.error,
                style: TextStyle(color: AppColors.textColor1),
              ),);
            }
            return const Loading();
            },
          ),
        ),);
  }


}

class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({ super.key, required this.photos });
  final List<Photo> photos;
  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
                items: widget.photos.map(_photoItem).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.photos.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 1.w,
                height: 1.h,
                margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.25.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blueColor
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _photoItem(Photo photo) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.h),
            child: CachedNetworkImage(
              imageUrl: photo.url,
              progressIndicatorBuilder: (_, __, ___) => const Loading(),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text(photo.title, style: TextStyle(fontSize: 18.sp, color: AppColors.textColor2))
      ],
    );
  }
}
