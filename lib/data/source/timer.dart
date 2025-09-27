import 'package:flutter/material.dart';

class MyTicker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) {
      debugPrint('ticker [x] => $x');
      return ticks - x - 1;
    }).take(ticks);
  }
}
