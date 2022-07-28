
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.halfTriangleDot(
            color: AppColors.blueColor, size: 10.w,),);
  }
}
