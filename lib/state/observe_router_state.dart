import 'package:flutter/material.dart';
import 'package:flutter_kborid_package/router/app_route_observer.dart';
import 'package:flutter_kborid_package/state/task_queue_handler.dart';

class ObserveRouterState<T extends StatefulWidget> extends State<T>
    with APPRouteAware, WidgetsBindingObserver {
  TaskQueueHandler get taskQueueHandler => _taskQueueHandler;
  String get routeName => _currentRoute.settings.name;
  TaskQueueHandler _taskQueueHandler = TaskQueueHandler();
  bool _isTop = false;
  Route _currentRoute;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(_buildCompleted);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    APPRouteObserver.defaultObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    APPRouteObserver.defaultObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (_isTop) {
          didAppear(false);
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (_isTop) {
          didDisappear();
        }
        break;
      case AppLifecycleState.detached:
        if (_isTop) {
          didDisappear();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  void didPush(Route route) {
    //push到当前页面，route当前页面的路由信息(视图树发生变化时调用，此时视图没有渲染完成)
    _currentRoute = route;
    _isTop = true;
    super.didPush(route);
  }

  @override
  void didPop() {
    //pop到上一个页面
    _isTop = false;
    didDisappear();
    super.didPop();
  }

  @override
  void didPopNext() {
    //pop到当前页面
    _isTop = true;
    didAppear(false);
    super.didPopNext();
  }

  @override
  void didPushNext(Route route) {
    //push到下一个页面，route下一个页面的路由信息
    _isTop = false;
    didDisappear();
    super.didPushNext(route);
  }

  @mustCallSuper
  void didAppear(bool firstLoad) {
    if (firstLoad) {
      //队列任务管理
      _taskQueueHandler.performNext();
    }
  }

  @mustCallSuper
  void didDisappear() {}

  void _buildCompleted(Duration timeStamp) {
    //页面第一次绘制完成
    didAppear(true);
  }
}
