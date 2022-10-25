import 'package:clean_news/widget/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        color: AppColors.success,
        size: 6.h,
      )
    );
  }
}