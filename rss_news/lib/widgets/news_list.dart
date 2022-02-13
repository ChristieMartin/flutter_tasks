import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rss_news/shared/constants.dart';
import 'package:rss_news/shared/list_provider.dart';
import 'package:rss_news/utils/utils.dart';

ListView listBuilder(BuildContext context, List list, ListProvider provider) {
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = list[index];
        return _itemWidget(context, item, provider);
      });
}

Widget _itemWidget(BuildContext context, RssItem item, ListProvider provider) {
  return Container(
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(2.h),
    ),
    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
    child: ListTile(
      title: Text(
        item.title!,
        style: TextStyle(
            fontSize: 16.sp, color: textColor, fontWeight: FontWeight.w500),
        maxLines: 2,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Wrap(
        children: [
          Container(
              margin: EdgeInsets.only(right: 3.w),
              child: GestureDetector(
                  onTap: () {
                    provider.addOrDeleteItem(item);
                  },
                  child: Icon(
                      provider.indexRssItem(item) != -1
                          ? Icons.star
                          : Icons.star_outline,
                      color: orangeColor))),
          Icon(Icons.keyboard_arrow_right, color: textColor.withOpacity(0.5)),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return newsCard(context, item);
          },
        );
      },
    ),
  );
}

Dialog newsCard(BuildContext context, RssItem item) {
  return Dialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        width: 80.w,
        height: 65.h,
        decoration: BoxDecoration(
            color: cardColor, borderRadius: BorderRadius.circular(3.h)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3.h),
              child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, _, progress) {
                    return SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: Padding(
                        padding: EdgeInsets.all(5.h),
                        child: CircularProgressIndicator(
                          color: orangeColor,
                          strokeWidth: 2.w,
                        ),
                      ),
                    );
                  },
                  imageUrl: item.enclosure!.url!,
                  height: 20.h,
                  alignment: Alignment.center,
                  fit: BoxFit.fill),
            ),
            Text(
              item.title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                margin: EdgeInsets.only(top: 2.h),
                height: 0.1.h,
                decoration: const BoxDecoration(color: textColor)),
            Text(
              item.description!,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
            GestureDetector(
              onTap: () {
                URLHandler.launchUrl(item.link!);
              },
              child: Container(
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(3.h)),
                child: Center(
                  child: Text("Читать далее...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        )),
  );
}
