import 'package:BYM/pages/coupon/index.dart';
import 'package:BYM/pages/list/index.dart';
//我的
import 'package:BYM/pages/mine/bind_email.dart';
import 'package:BYM/pages/mine/bind_success.dart';
import 'package:BYM/pages/mine/change_pwd.dart';
import 'package:BYM/pages/mine/con_logoff.dart';
import 'package:BYM/pages/mine/connect.dart';
import 'package:BYM/pages/mine/feed_back.dart';
import 'package:BYM/pages/mine/language.dart';
import 'package:BYM/pages/mine/logoff.dart';
import 'package:BYM/pages/mine/more.dart';
//测试
import 'package:BYM/pages/tcp/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
      name: '/Home',
      page: () => HomePage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/SetPages',
      page: () => SetPages(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/TcpPage',
      page: () => TcpPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/FeedBack',
      page: () => MineFeedback(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/MineLogoff',
      page: () => MineLogoff(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/ConLogoff',
      page: () => Conlogoff(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/Connect',
      page: () => Connect(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/MineMore',
      page: () => MineMore(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/Language',
      page: () => Language(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/ChangePwd',
      page: () => ChangePwd(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/BindEmail',
      page: () => BindEmail(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/BindSuccess',
      page: () => BindSuccess(),
      transition: Transition.rightToLeftWithFade),
];

class BYRoute {
  static toNamed(String page) {
    Get.toNamed(page);
  }

  static back(String page) {
    Get.back();
  }

  static push(Widget page, Transition transition) {
    Get.to(page);
  }
}
