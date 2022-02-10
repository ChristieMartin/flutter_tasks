import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';
import 'package:weather_bloc/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff001D22),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xff001D22),
          )),
      home: ResponsiveSizer(builder: (context, orientation, screenType) {
        return const MyHomePage();
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Scaffold _loadingScaffold() {
    return const Scaffold(
        body: Center(
      child:
          CircularProgressIndicator(strokeWidth: 6, color: Color(0xff3DB3CA)),
    ));
  }

  Scaffold loadedScaffold(BuildContext context, WeatherLoaded state) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(const WeatherSearchInit());
            },
          ),
        ),
        body: SafeArea(
          child: WeatherScreen(
            weather: state.weather,
            hourlyWeather: state.hourlyWeather,
          ),
        ));
  }

  Container _searchFormField(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        height: 7.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: const Color(0xff0F343C),
          borderRadius: BorderRadius.circular(5.h),
        ),
        child: TextFormField(
          controller: _controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.search, color: const Color(0xff3DB3CA), size: 4.h),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.h)),
            contentPadding: EdgeInsets.only(left: 1.w, bottom: 1.h),
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontSize: 18.sp,
            ),
            hintText: "Moscow",
          ),
          onFieldSubmitted: (String? query) {
            if (query!.trim() != "") {
              BlocProvider.of<WeatherBloc>(context)
                  .add(WeatherRequest(cityName: query));
              _controller.clear();
            }
          },
        ));
  }

  Scaffold _searchScaffold(BuildContext context, WeatherSearch state) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _searchFormField(context),
                IconButton(
                    icon:
                        const Icon(Icons.my_location, color: Color(0xff3DB3CA)),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(const WeatherCurrentPositionRequest());
                    })
              ],
            )),
            Positioned(
                bottom: 42.h,
                child: Text(state.error,
                    style: const TextStyle(color: Color(0xffF05F40))))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        Scaffold currentScaffold = state is WeatherSearch
            ? _searchScaffold(context, state)
            : state is WeatherLoaded
                ? loadedScaffold(context, state)
                : _loadingScaffold();
        return currentScaffold;
      }),
    );
  }
}
