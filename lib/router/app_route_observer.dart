import 'package:flutter/material.dart';

abstract class APPRouteAware {
  void didPopNext() {}

  void didPush(Route<dynamic> route) {}

  void didPop() {}

  void didPushNext(Route<dynamic> route) {}
}

class APPRouteObserver<R extends Route<dynamic>> extends NavigatorObserver {
  static APPRouteObserver get defaultObserver => _defaultObserver;

  static APPRouteObserver _defaultObserver = APPRouteObserver();
  final Map<R, Set<APPRouteAware>> _listeners = <R, Set<APPRouteAware>>{};
  Route<dynamic> lastRoute;

  void subscribe(APPRouteAware routeAware, R route) {
    assert(routeAware != null);
    assert(route != null);
    final Set<APPRouteAware> subscribers = _listeners.putIfAbsent(route, () => <APPRouteAware>{});
    if (subscribers.add(routeAware)) {
      routeAware.didPush(lastRoute);
    }
  }

  void unsubscribe(APPRouteAware routeAware) {
    assert(routeAware != null);
    for (final R route in _listeners.keys) {
      final Set<APPRouteAware> subscribers = _listeners[route];
      subscribers?.remove(routeAware);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route is R && previousRoute is R) {
      final List<APPRouteAware> previousSubscribers = _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (final APPRouteAware routeAware in previousSubscribers) {
          routeAware.didPopNext();
        }
      }

      final List<APPRouteAware> subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (final APPRouteAware routeAware in subscribers) {
          routeAware.didPop();
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    lastRoute = route;
    if (route is R && previousRoute is R) {
      final Set<APPRouteAware> previousSubscribers = _listeners[previousRoute];

      if (previousSubscribers != null) {
        for (final APPRouteAware routeAware in previousSubscribers) {
          routeAware.didPushNext(route);
        }
      }
    }
  }
}
