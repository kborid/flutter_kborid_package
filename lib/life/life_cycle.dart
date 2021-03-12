import 'package:flutter/cupertino.dart';

abstract class APPRouteAware {
  void didPopNext() {}

  void didPush(Route<dynamic> route) {}

  void didPop() {}

  void didPushNext(Route<dynamic> route) {}
}