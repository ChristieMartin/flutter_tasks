import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/shared/shared_widgets.dart';
import 'package:auth_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppTheme.colors.lightGray,
          title: Text("Settings",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.colors.darkGray)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _settingsTile(Icons.person, "Change username", () {
              _usernameDialog(context);
            }),
            _settingsTile(Icons.key, "Change password", () {
              _passwordDialog(context);
            }),
            _settingsTile(Icons.exit_to_app, "Logout", () {
              BlocProvider.of<AuthBloc>(context).add(Logout());
            })
          ]),
        ));
  }

  Future<dynamic> _passwordDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return const PasswordDialog();
        });
  }

  Future<dynamic> _usernameDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const UsernameDialog();
        });
  }

  Widget _settingsTile(IconData icon, String text, void Function()? onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h)),
      child: Container(
          height: 8.h,
          decoration: BoxDecoration(
              color: AppTheme.colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.h),
                  bottomLeft: Radius.circular(2.h),
                  topRight: Radius.circular(4.h),
                  bottomRight: Radius.circular(4.h))),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.h),
                  color: AppTheme.colors.orange.withOpacity(0.1),
                ),
                child: SizedBox(
                  height: 5.h,
                  width: 5.h,
                  child: Icon(icon, color: AppTheme.colors.orange),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(text,
                  style: TextStyle(
                      color: AppTheme.colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500))
            ]),
            Icon(Icons.arrow_forward_ios,
                color: AppTheme.colors.darkGray.withOpacity(0.25), size: 2.5.h)
          ])),
    );
  }
}

class UsernameDialog extends StatefulWidget {
  const UsernameDialog({Key? key}) : super(key: key);

  @override
  State<UsernameDialog> createState() => _UsernameDialogState();
}

class _UsernameDialogState extends State<UsernameDialog> {
  TextEditingController controller = TextEditingController();
  String? error;

  @override
  void initState() {
    final state = BlocProvider.of<AuthBloc>(context).state as LoginSuccess;
    controller.text = state.user.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
      child: SizedBox(
          width: 90.w,
          height: 40.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                height: 13.h,
                child: SharedWidgets.textField(
                    "Enter new username", "PupaLupa228", controller,
                    errorText: error),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: SharedWidgets.textButton("ok", onPressed: () {
                  if (controller.text.trim() != "") {
                    BlocProvider.of<AuthBloc>(context)
                        .add(ChangeUsername(controller.text.trim()));
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      error = "Username must not be empty";
                    });
                  }
                }),
              ),
            ],
          )),
    );
  }
}

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({Key? key}) : super(key: key);

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  TextEditingController curController = TextEditingController();
  TextEditingController fstController = TextEditingController();
  TextEditingController sndController = TextEditingController();
  String? firstError;
  String? secondError;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
      child: SizedBox(
          width: 90.w,
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                height: 13.h,
                child: SharedWidgets.textField(
                    "Enter current password", "••••••••", curController,
                    obscureText: true, errorText: firstError),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                height: 13.h,
                child: SharedWidgets.textField(
                    "Enter new password", "••••••••", fstController,
                    obscureText: true, errorText: secondError),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                height: 13.h,
                child: SharedWidgets.textField(
                    "Enter new password again", "••••••••", sndController,
                    obscureText: true, errorText: secondError),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: SharedWidgets.textButton(
                  "ok",
                  onPressed: () {
                    final state = BlocProvider.of<AuthBloc>(context).state
                        as LoginSuccess;
                    if (state.user.password == curController.text.trim()) {
                      if (fstController.text.trim() != "" &&
                          fstController.text.trim() ==
                              sndController.text.trim()) {
                        BlocProvider.of<AuthBloc>(context)
                            .add(ChangePassword(fstController.text.trim()));
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          secondError = "Passwords must be equal";
                        });
                      }
                    } else {
                      setState(() {
                        firstError = "Enter old password correctly";
                      });
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
