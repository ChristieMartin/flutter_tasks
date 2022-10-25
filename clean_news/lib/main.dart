import 'package:clean_news/router/app_router.gr.dart';
import 'package:clean_news/widget/ui_kit/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),      
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      }
    );
  }
}

