library flutter_kborid_package;

export 'package:flutter_kborid_package/navigator/app_route_navigator.dart';
export 'package:flutter_kborid_package/router/app_route_observer.dart';
export 'package:flutter_kborid_package/router/app_routes.dart';
export 'package:flutter_kborid_package/state/observe_router_state.dart';
export 'package:flutter_kborid_package/state/task_queue_handler.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  static int addTwo(int value) => value + 2;
}
