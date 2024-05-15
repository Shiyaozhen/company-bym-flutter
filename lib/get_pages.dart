import 'package:BYM/pages/home/index.dart';
import 'package:BYM/pages/home/mine/bindAgent/index.dart';
//我的
import 'package:BYM/pages/home/mine/bindemail/bind_email.dart';
import 'package:BYM/pages/home/mine/bindemail/bind_success.dart';
import 'package:BYM/pages/home/mine/con_logoff.dart';
import 'package:BYM/pages/home/mine/connect.dart';
import 'package:BYM/pages/home/mine/feed_back.dart';
import 'package:BYM/pages/home/mine/language.dart';
import 'package:BYM/pages/home/mine/logoff.dart';
import 'package:BYM/pages/home/mine/more.dart';
import 'package:BYM/pages/home/mine/password/change_pwd.dart';
//首页概览
import 'package:BYM/pages/home/overview/index.dart';
//修改电站信息
import 'package:BYM/pages/home/plant/change_info.dart';
//首页电站
import 'package:BYM/pages/home/plant/index.dart';
import 'package:BYM/pages/list/index.dart';
//登录
import 'package:BYM/pages/login/login.dart';
//注册
import 'package:BYM/pages/login/sign_up.dart';
//电站详情
import 'package:BYM/pages/powerstation/detail/index.dart';
import 'package:BYM/pages/powerstation/index.dart';
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
      name: '/Login',
      page: () => Login(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/SignUp',
      page: () => SignUp(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/OverView',
      page: () => OverViewIndex(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/Plant',
      page: () => PlantIndex(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/ChangeInfo',
      page: () => ChangeInfo(),
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
    name: '/ChangePwd',
    page: () => const ChangePwd(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/Language',
    page: () => const Language(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/BindEmail',
    page: () => const BindEmail(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/BindAgent',
    page: () => const BindAgent(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/DetailIndex',
    page: () => const DetailIndex(arguments: {},),
    transition: Transition.rightToLeftWithFade,
  ),
   GetPage(
    name: '/PowerStationIndex',
    page: () => const PowerStationIndex(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/Connect',
    page: () => Connect(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/MineMore',
    page: () => MineMore(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/BindSuccess',
    page: () => BindSuccess(),
    transition: Transition.rightToLeftWithFade,
  ),
];

class BYRoute {
  static toNamed(String page, {dynamic arguments}) {
    Get.toNamed(page, arguments: arguments);
  }

  static back() {
    Get.back();
  }

  static off(Widget page, {dynamic arguments}) {
    Get.off(page, arguments: arguments);
  }

  static push(Widget page, {dynamic arguments}) {
    Get.to(page, arguments: arguments);
  }
}

