import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  Future<int> delayData() {
    return Future.delayed(Duration(seconds: 2), () {
      return 100;
    });
  }

  Stream<int> randomIntStream({int intervalMs = 1000}) async* {
    final random = math.Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: intervalMs));
      yield random.nextInt(100);  
    }
  }
}
