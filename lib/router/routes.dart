import 'package:bloc_starter/app.dart';
import 'package:bloc_starter/features/counter/counter.dart';
import 'package:bloc_starter/features/infinite_list/infinite_list.dart';
import 'package:bloc_starter/features/timer/timer.dart';
import 'package:bloc_starter/router/route_names.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static GoRouter get route => _route;
  static final _route = GoRouter(
    initialLocation: RouteNames.root,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.root,
        builder: (context, state) {
          return MainApp();
        },
        routes: [
          GoRoute(
            path: RouteNames.counter,
            builder: (context, state) {
              return CounterPage();
            },
          ),
          GoRoute(
            path: RouteNames.timer,
            builder: (context, state) {
              return TimerPage();
            },
          ),
          GoRoute(
            path: RouteNames.infiniteList,
            builder: (context, state) {
              return InfiniteListPage();
            },
          ),
        ],
      ),
    ],
  );
}
