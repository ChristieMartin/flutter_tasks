import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/page/auth_page/login_page.dart';
import 'package:auth_app/page/home_page/bottom_navigation.dart';
import 'package:auth_app/shared/shared_widgets.dart';
import 'package:auth_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          if (state.error != null) {
            SharedWidgets.dialog(context, state.error!,
                "https://skr.sh/s/250422/zJXaVrly.png?download=1&name=Скриншот%2014-06-2022%2022:56:54.png");
          }
        }
        if (state is LoginSuccess) {
          if (state.error != null) {
            SharedWidgets.dialog(context, state.error!,
                "https://skr.sh/s/250422/zJXaVrly.png?download=1&name=Скриншот%2014-06-2022%2022:56:54.png");
          }
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoginPage();
        }
        if (state is LoginSuccess) {
          return const BottomNavigation();
        }
        return const Loading();
      },
    ));
  }
}
