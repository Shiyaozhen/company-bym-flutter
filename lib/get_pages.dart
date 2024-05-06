import 'package:BYM/pages/coupon/index.dart';
import 'package:BYM/pages/list/index.dart';
import 'package:BYM/pages/mine/feedback.dart';
import 'package:BYM/pages/tcp/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
List<GetPage<dynamic>> pages = [
  GetPage(name: '/Home', page: () => HomePage()),
  GetPage(name: '/SetPages', page: () => SetPages()),
  GetPage(name: '/TcpPage', page: () => TcpPage()),
  GetPage(name: '/FeedBack', page: () => MineFeedback()),
];

class BYRoute {
  static toNamed(String page) {
      Get.toNamed(page);
  }
  static back(String page) {
      Get.back();
  }
  static push(Widget page) {
      Get.to(page);
  }
}
