import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_kborid_package/widget/not_found_page.dart';

enum AppRoutesHandlerType {
  route,
  function,
}

typedef Widget AppRoutesHandlerFunc(BuildContext context, Map<String, List<String>> parameters);

class AppRoutes {
  static Router get router => Router.appRouter;
  static final rootPage = Navigator.defaultRouteName;

  static final Handler _defaultHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => NotFoundWidget());

  static void configureRoutes(Map<String, AppRoutesHandler> routerMap, {Handler notFoundHandler}) {
    if (routerMap == null || routerMap.isEmpty) {
      router.define(rootPage, handler: Handler(handlerFunc: (_, __) => NotFoundWidget()));
    }

    routerMap.forEach((key, value) {
      switch (value.type) {
        case AppRoutesHandlerType.route:
          router.define(key,
              handler: Handler(type: HandlerType.route, handlerFunc: value.handlerFunc));
          break;
        case AppRoutesHandlerType.function:
          router.define(key,
              handler: Handler(type: HandlerType.function, handlerFunc: value.handlerFunc));
          break;
      }
    });

    router.notFoundHandler = notFoundHandler ?? _defaultHandler;
  }
}

class AppRoutesHandler {
  AppRoutesHandler({this.type = AppRoutesHandlerType.route, this.handlerFunc});
  final AppRoutesHandlerType type;
  final AppRoutesHandlerFunc handlerFunc;
}
