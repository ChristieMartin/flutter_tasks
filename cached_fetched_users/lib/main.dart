import 'package:cached_fetched_users/pages/home_page/bloc/users_bloc.dart';
import 'package:cached_fetched_users/router/router.gr.dart';
import 'package:cached_fetched_users/widgets/ui_kit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: ResponsiveSizer(builder: (context, orientation, screenType) {
          return BlocProvider(
              create: (context) => UsersBloc()..add(LoadUsers()),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                routerDelegate: AppRouter().delegate(),
                routeInformationParser: AppRouter().defaultRouteParser(),
              ),);
        },),);
  }
}
