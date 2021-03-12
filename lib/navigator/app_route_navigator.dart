import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_kborid_package/router/app_routes.dart';

class AppNavigator {
  static void push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Map<String, dynamic> params,
      TransitionType transition = TransitionType.cupertino}) {
    unFocus();

    AppRoutes.router.navigateTo(context, _formatPath(path, params: params),
        replace: replace, clearStack: clearStack, transition: transition);
  }

  static void pushResult(BuildContext context, String path, Function(Object) resultFn,
      {bool replace = false,
      bool clearStack = false,
      Map<String, dynamic> params,
      TransitionType transition = TransitionType.cupertino}) {
    unFocus();
    AppRoutes.router
        .navigateTo(context, _formatPath(path, params: params),
            replace: replace, clearStack: clearStack, transition: transition)
        .then((result) {
      if (resultFn != null) {
        resultFn(result);
      }
    }).catchError((error) => print('$error'));
  }

  static void goBack(BuildContext context) {
    unFocus();
    Navigator.of(context).pop();
  }

  static void goBackWithParams(BuildContext context, dynamic result) {
    unFocus();
    Navigator.of(context).pop(result);
  }

  static void popWithName(BuildContext context, String name) {
    Navigator.of(context).popUntil(ModalRoute.withName(name));
  }

  static void popStartsWithName(BuildContext context, String name) {
    Navigator.of(context).popUntil((route) => route.settings.name.startsWith(name));
  }

  /// 跳转到Native页面
  ///
  /// path：与Native定义的页面路径
  ///
  /// isFullScreenDialog： 是否为从屏幕底部推出的全屏弹框
  //TODO:有需求的时候再支持从flutter页面跳转到native页面
  // static void push2Native(String path, {bool isFullScreenDialog = false}) {}

  static void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String _formatPath(String path, {Map<String, dynamic> params}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key] ?? "");
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    return path + query;
  }
}
