import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/shared/shared_widgets.dart';
import 'package:auth_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fstPasswordController = TextEditingController();
  final TextEditingController sndPasswordController = TextEditingController();

  String usernameText = "";
  String fstPasswordText = "";
  String sndPasswordText = "";

  String? errorText;

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {
        usernameText = usernameController.text.trim().toLowerCase();
      });
    });

    fstPasswordController.addListener(() {
      setState(() {
        fstPasswordText = fstPasswordController.text.trim();
      });
      if (sndPasswordController.text == fstPasswordController.text) {
        setState(() {
          errorText = null;
        });
      }
      if (sndPasswordController.text != "" &&
          fstPasswordController.text != "" &&
          sndPasswordController.text != fstPasswordController.text) {
        setState(() {
          errorText = "Passwords must be equal";
        });
      }
    });

    sndPasswordController.addListener(() {
      setState(() {
        sndPasswordText = sndPasswordController.text.trim();
      });
      if (sndPasswordController.text == fstPasswordController.text) {
        setState(() {
          errorText = null;
        });
      }
      if (sndPasswordController.text != "" &&
          fstPasswordController.text != "" &&
          sndPasswordController.text != fstPasswordController.text) {
        setState(() {
          errorText = "Passwords must be equal";
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.colors.lightGray,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
                color: AppTheme.colors.darkGray.withOpacity(0.25))),
        title: Text("Registration",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.colors.darkGray)),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.symmetric(vertical: 2.h),
              height: 13.h,
              child: SharedWidgets.textField(
                  "Username", "BigFloppa228", usernameController)),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.symmetric(vertical: 2.h),
              height: 13.h,
              child: SharedWidgets.textField(
                  "Password", "••••••••", fstPasswordController,
                  obscureText: true, errorText: errorText)),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.symmetric(vertical: 2.h),
              height: 13.h,
              child: SharedWidgets.textField(
                  "Password again", "••••••••", sndPasswordController,
                  obscureText: true, errorText: errorText)),
          Expanded(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  child: SharedWidgets.textButton("Register", onPressed: () {
                        if (usernameText != "" &&
                            fstPasswordText != "" &&
                            fstPasswordText == sndPasswordText) {
                          Navigator.pop(context);
                          BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                              username: usernameText, password: fstPasswordText));
                        }
                      },
                      buttonColor: usernameText != "" &&
                              fstPasswordText != "" &&
                              sndPasswordText != ""
                          ? AppTheme.colors.orange
                          : AppTheme.colors.darkGray.withOpacity(0.5))))
        ],
      ),
    );
  }
}
