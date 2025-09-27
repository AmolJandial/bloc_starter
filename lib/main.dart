import 'package:bloc/bloc.dart';
import 'package:bloc_starter/app.dart';
import 'package:bloc_starter/bloc_state_observer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = const BlocStateObserver();
  EquatableConfig.stringify = true;
  runApp(const MyApp());
}
