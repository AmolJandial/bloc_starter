import 'package:bloc_starter/features/timer/timer.dart';
import 'package:bloc_starter/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.timerAppBar)),
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 32,
            children: [TimerText(), Actions()],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text('$minutesStr : $secondsStr', style: Theme.of(context).textTheme.headlineLarge);
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                FloatingActionButton(
                  onPressed:
                      () => context.read<TimerBloc>().add(TimerStarted(duration: state.duration)),
                  child: Icon(Icons.play_arrow_rounded),
                ),
              ],
              TimerRunInProgress() => [
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                  child: Icon(Icons.pause_rounded),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                  child: Icon(Icons.replay_rounded),
                ),
              ],
              TimerRunPause() => [
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerResumed()),
                  child: Icon(Icons.play_arrow_rounded),
                ),
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                  child: Icon(Icons.replay_rounded),
                ),
              ],
              TimerRunComplete() => [
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                  child: Icon(Icons.replay_rounded),
                ),
              ],
            },
          ],
        );
      },
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.blue.shade500],
        ),
      ),
    );
  }
}
