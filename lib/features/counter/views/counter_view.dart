import 'package:bloc_starter/features/counter/cubit/counter_cubit.dart';
import 'package:bloc_starter/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.couterScreenAppBar)),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headlineLarge);
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 8,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'increment',
            key: const Key('counterView_increment_fab'),
            onPressed: () => context.read<CounterCubit>().increment(),
            child: Icon(Icons.add_rounded),
          ),
          FloatingActionButton(
            heroTag: 'decrement',
            key: const Key('counterView_decrement_fab'),
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: Icon(Icons.remove_rounded),
          ),
        ],
      ),
    );
  }
}
