import 'package:auth_app/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletons/skeletons.dart';

class SharedWidgets {
  static Future<void> dialog(
      BuildContext context, final String text, final String imageUrl) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.h)),
            child: SizedBox(
                width: 90.w,
                height: 40.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(bottom: 5.h, left: 8.w, right: 8.w),
                      height: 20.h,
                      width: 100.w,
                      child: SharedWidgets.image(
                        imageUrl,
                      ),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme.colors.darkGray,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                )),
          );
        });
  }

  static Widget image(final String imageUrl) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 4.w, color: AppTheme.colors.darkGray.withOpacity(0.25))
      ]),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4.w),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, _, __) {
              return SkeletonAvatar(
                style: SkeletonAvatarStyle(width: 50.w, height: 100.h),
              );
            },
          )),
    );
  }

  static Widget textButton(final String text,
      {void Function()? onPressed, Color? buttonColor}) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(4.w),
          height: 7.h,
          decoration: BoxDecoration(
              color: buttonColor ?? AppTheme.colors.orange,
              borderRadius: BorderRadius.circular(1.5.h)),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppTheme.colors.white,
            ),
          )),
        ));
  }

  static Widget textField(final String label, final String hintText,
      final TextEditingController controller,
      {bool obscureText = false, String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: AppTheme.colors.darkGray,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorMaxLines: 1,
            errorText: errorText,
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppTheme.colors.darkGray.withOpacity(0.25),
                fontSize: 16.sp),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(width: 0.1.h, color: AppTheme.colors.orange)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.1.h,
                    color: AppTheme.colors.darkGray.withOpacity(0.25))),
          ),
        ),
      ],
    );
  }
}
