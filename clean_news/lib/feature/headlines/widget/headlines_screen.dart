import 'package:clean_news/feature/headlines/bloc/headlines_bloc.dart';
import 'package:clean_news/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeadlinesScreen extends StatelessWidget {
  const HeadlinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            HeadlinesBloc()..add(const HeadlinesEvent.fetchHeadlines()),
        child: BlocBuilder<HeadlinesBloc, HeadlinesState>(
          builder: (context, state) {
            return state.when(
              loading: () => const AppLoading(),
              error: (error) => Center(child: Text(error)),
              headlinesFetched: (articles) => Container(),
            );
          },
        ),
      ),
    );
  }
}
