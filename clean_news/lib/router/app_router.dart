import 'package:auto_route/annotations.dart';
import 'package:clean_news/feature/home/widget/home_screen.dart';

@MaterialAutoRouter(              
  replaceInRouteName: 'Page,Route',              
  routes: <AutoRoute>[       
    AutoRoute(page: HomeScreen, initial: true),
  ],              
)              
class $AppRouter {}              