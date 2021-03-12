import 'package:flutter/material.dart';
import 'package:flutter_kborid_package/flutter_kborid_package.dart';

class PageB extends StatefulWidget {
  @override
  _PageBState createState() {
    return _PageBState();
  }
}

class _PageBState extends ObserveRouterState<PageB> {
  @override
  void didAppear(bool firstLoad) {
    print('B页面${firstLoad ? '第一次' : ''}展示');
    super.didAppear(firstLoad);
  }

  @override
  void didDisappear() {
    print('B页面消失');
    super.didDisappear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        title: Text('页面B'),
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
          children: <Widget>[Text('这是第二个页面')],
        ),
      ),
    );
  }
}
