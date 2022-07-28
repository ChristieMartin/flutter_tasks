import 'package:auto_route/auto_route.dart';
import 'package:cached_fetched_users/pages/home_page/bloc/users_bloc.dart';
import 'package:cached_fetched_users/pages/user_page/models/user.dart';
import 'package:cached_fetched_users/router/router.gr.dart';
import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            return UserList(users: state.users);
          }
          if (state is UsersLoadingFailed) {
            return _errorScreen(state.error);
          }
          return const Loading();
        },
      ),
    );
  }

  Widget _errorScreen(String error) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Text(
          error,
          style: TextStyle(color: AppColors.textColor3),
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key, required this.users});
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, index) => AppTextButton(
        context,
        firstText: users[index].username,
        secondText: users[index].name,
        onPressed: () {
          context.router.push(UserRoute(user: users[index]));
        },
        height: 7.h,
      ),
    );
  }
}
