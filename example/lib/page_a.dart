import 'package:flutter/material.dart';
import 'package:flutter_kborid_package/flutter_kborid_package.dart';

class PageA extends StatefulWidget {
  @override
  _PageAState createState() {
    return _PageAState();
  }
}

class _PageAState extends ObserveRouterState<PageA> {
  @override
  void didAppear(bool firstLoad) {
    print('A页面${firstLoad ? '第一次' : ''}展示');
    super.didAppear(firstLoad);
  }

  @override
  void didDisappear() {
    print('A页面消失');
    super.didDisappear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        title: Text('页面A'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            AppNavigator.goBack(context);
          },
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('这是第一个页面'),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                AppNavigator.push(context, 'pageB');
              },
            )
          ],
        ),
      ),
    );
  }
}
