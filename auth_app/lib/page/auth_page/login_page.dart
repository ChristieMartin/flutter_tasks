import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/shared/shared_widgets.dart';
import 'package:auth_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String usernameText = "";
  String passwordText = "";

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {
        usernameText = usernameController.text.trim().toLowerCase();
      });
    });
    passwordController.addListener(() {
      setState(() {
        passwordText = passwordController.text.trim();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              height: 35.h,
              width: 50.w,
              child: Center(
                child: SharedWidgets.image(
                    "https://i.ibb.co/rvZyXCj/browser-kwul-B1g-TUI.png"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 10.h,
              child: SharedWidgets.textField(
                  "Username", "FloppaCat228", usernameController),
            ),
            SizedBox(height: 2.h),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 60.w,
                      child: SharedWidgets.textField(
                          "Password", "••••••••", passwordController,
                          obscureText: true),
                    ),
                    SharedWidgets.textButton("ok",
                        buttonColor: usernameText != "" && passwordText != ""
                            ? AppTheme.colors.orange
                            : AppTheme.colors.darkGray.withOpacity(0.5),
                        onPressed: () {
                      if (usernameText != "" && passwordText != "") {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            username: usernameText, password: passwordText));
                        passwordController.clear();
                        passwordText = "";
                      }
                    })
                  ],
                )),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User?",
                  style: TextStyle(
                      color: AppTheme.colors.darkGray.withOpacity(0.25),
                      fontSize: 17.sp),
                ),
                SizedBox(width: 2.w),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/sign_up");
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: AppTheme.colors.orange, fontSize: 17.sp),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
