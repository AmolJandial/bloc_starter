import 'package:bloc_starter/router/router.dart';
import 'package:bloc_starter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRoutes.route, debugShowCheckedModeBanner: false);
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.home)),
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            FilledButton(
              onPressed: () {
                context.go(RouteNames.counter);
              },
              child: Text(AppStrings.counter),
            ).withFullWidth.withMarginH8,
            FilledButton(
              onPressed: () {
                context.go(RouteNames.timer);
              },
              child: Text(AppStrings.timerAppBar),
            ).withFullWidth.withMarginH8,
            FilledButton(
              onPressed: () {
                context.go(RouteNames.infiniteList);
              },
              child: Text(AppStrings.infiniteTitle),
            ).withFullWidth.withMarginH8,
          ],
        ),
      ),
    );
  }
}
