import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(this.context, {
    super.key,
    required this.onPressed,
    this.height,
    required this.firstText,
    required this.secondText,
    this.firstTextStyle,
    this.secondTextStyle,
  });
  final BuildContext context;
  final VoidCallback onPressed;
  final double? height;
  final String firstText;
  final String secondText;
  final TextStyle? firstTextStyle;
  final TextStyle? secondTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: TextButton(
        onPressed: onPressed,
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
            SizedBox(
              width: 75.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstText,
                    style: firstTextStyle ??
                        TextStyle(color: AppColors.textColor1),
                  ),
                  Text(
                    secondText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: secondTextStyle ??
                        TextStyle(color: AppColors.textColor3),
                  )
                ],
              ),
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
