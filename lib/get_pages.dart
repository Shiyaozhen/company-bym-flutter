import 'package:BYM/pages/coupon/index.dart';
import 'package:BYM/pages/list/index.dart';
import 'package:BYM/pages/mine/conlogoff.dart';
import 'package:BYM/pages/mine/feedback.dart';
import 'package:BYM/pages/mine/logoff.dart';
import 'package:BYM/pages/tcp/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
List<GetPage<dynamic>> pages = [
  GetPage(name: '/Home', page: () => HomePage(),transition: Transition.rightToLeftWithFade),
  GetPage(name: '/SetPages', page: () => SetPages(),transition: Transition.rightToLeftWithFade),
  GetPage(name: '/TcpPage', page: () => TcpPage(),transition: Transition.rightToLeftWithFade),
  GetPage(name: '/FeedBack', page: () => MineFeedback(),transition: Transition.rightToLeftWithFade),
  GetPage(name: '/MineLogoff', page: () => MineLogoff(),transition: Transition.rightToLeftWithFade),
  GetPage(name: '/ConLogoff', page: () => Conlogoff(),transition: Transition.rightToLeftWithFade),
];

class BYRoute {
  static toNamed(String page) {
      Get.toNamed(page);
  }
  static back(String page) {
      Get.back();
  }
  static push(Widget page,Transition transition) {
      Get.to(page);
  }
}
