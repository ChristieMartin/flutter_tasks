import 'package:auth_app/page/auth_page/auth_page.dart';
import 'package:auth_app/page/auth_page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args;
    // if (settings.arguments != null) {
    //   args = settings.arguments as Map;
    // } else {
    //   args = null;
    // }

    switch (settings.name) {
      case "/":
        return PageTransition(
            child: const AuthPage(),
            settings: const RouteSettings(name: "/"),
            type: PageTransitionType.fade);
      case "/sign_up":
        return PageTransition(
            child: const SignUpPage(),
            settings: const RouteSettings(name: "/sign_up"),
            type: PageTransitionType.fade);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return PageTransition(
        child: const Center(child: Text("error route")),
        settings: const RouteSettings(name: "/error"),
        type: PageTransitionType.fade);
  }
}
