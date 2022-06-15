import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/shared/shared_widgets.dart';
import 'package:auth_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                height: 35.h,
                width: 90.w,
                child: SharedWidgets.image(
                    "https://skr.sh/s/250422/xnoyYOGB.png?download=1&name=Скриншот%2015-06-2022%2002:06:19.png"),
              ),
              SizedBox(
                width: 90.w,
                child: Text("Welcome, ${state.user.username}!",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.bold)),
              )
            ],
          );
        }
        return const Loading();
      },
    );
  }
}
