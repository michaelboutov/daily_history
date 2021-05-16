import 'package:flutter/material.dart';

// global int to using archive , number of current article in archive
class ArticleNumber with ChangeNotifier {
  int _count = 1;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void setNumber(double i) {
    _count = i.toInt();
  }

  void setNumberInt(int i) {
    _count = i;
  }

  int num() {
    return _count;
  }
}

// count the number of articles was opend, for showing ad evry 3 new articles
class AdCounter with ChangeNotifier {
  int _adCount = 1;
  int get count => _adCount;

  void increment() {
    _adCount++;
    notifyListeners();
  }
}
