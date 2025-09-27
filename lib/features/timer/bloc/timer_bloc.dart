import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_starter/data/source/timer.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final MyTicker _ticker;
  StreamSubscription<int>? _subscription;

  TimerBloc({required MyTicker ticker}) : _ticker = ticker, super(TimerInitial(_duration)) {
    on<TimerStarted>(_onTimerStarted);
    on<_TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) async {
    emit(TimerRunInProgress(_duration));
    _subscription?.cancel();
    _subscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onTimerTicked(_TimerTicked event, Emitter<TimerState> emit) async {
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : TimerRunComplete());
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) async {
    if (state is TimerRunInProgress) {
      _subscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) async {
    if (state is TimerRunPause) {
      _subscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) async {
    _subscription?.cancel();
    emit(TimerInitial(_duration));
  }
}
