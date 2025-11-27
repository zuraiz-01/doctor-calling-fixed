import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt index = 0.obs; // HOME = PAGE 0
  PageController pageController = PageController(initialPage: 0);

  void changeTab(int i) {
    index.value = i;
    pageController.jumpToPage(i);
  }
}
