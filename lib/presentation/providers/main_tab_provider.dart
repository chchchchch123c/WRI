import 'package:flutter/material.dart';

MainTabProvider mainTabProvider = MainTabProvider();

class MainTabProvider extends ChangeNotifier {

  int currentIndex = 0;

  void setCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

}