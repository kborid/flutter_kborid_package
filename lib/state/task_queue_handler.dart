import 'package:flutter/material.dart';

class TaskQueueHandler {
  List<VoidCallback> _taskQueue = List();

  void addTask(VoidCallback callBack) {
    if (callBack != null) {
      _taskQueue.add(callBack);
    }
  }

  bool contains(VoidCallback callBack) {
    return _taskQueue.contains(callBack);
  }

  void insertTask(VoidCallback callBack) {
    if (callBack != null) {
      _taskQueue.insert(0, callBack);
    }
  }

  bool get isEmpty {
    return _taskQueue.isEmpty;
  }

  void performNext() {
    if (isEmpty) return null;
    _taskQueue.removeAt(0)();
  }
}
