import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/route_generator.dart';
import 'package:auth_app/service/authentication.dart';
import 'package:auth_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => AuthenticationService())
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => AuthBloc(
                      RepositoryProvider.of<AuthenticationService>(context))
                    ..add(InitServiceEvent()))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: "/",
            ),
          ),
        );
      }),
    );
  }
}
