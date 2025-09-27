import 'package:bloc_starter/data/source/source.dart';
import 'package:bloc_starter/features/timer/bloc/timer_bloc.dart';
import 'package:bloc_starter/features/timer/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => TimerBloc(ticker: MyTicker()), child: TimerView());
  }
}
