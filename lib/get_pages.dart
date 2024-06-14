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
import 'package:BYM/pages/home/plant/edit.dart';
import 'package:BYM/pages/home/plant/configNet/blue/f_add_plant.dart';
import 'package:BYM/pages/home/plant/configNet/blue/f_blue_add_device_step1.dart';
import 'package:BYM/pages/home/plant/configNet/blue/f_blue_add_device_step2.dart';
import 'package:BYM/pages/home/plant/configNet/blue/f_blue_add_device_step3.dart';
import 'package:BYM/pages/home/plant/configNet/blue/f_blue_search_device.dart';
import 'package:BYM/pages/home/plant/configNet/scan.dart';
import 'package:BYM/pages/home/plant/configNet/byhand.dart';

//首页电站
import 'package:BYM/pages/home/plant/index.dart';
import 'package:BYM/pages/list/index.dart';

//登录
import 'package:BYM/pages/login/login.dart';

//注册
import 'package:BYM/pages/login/sign_up.dart';

//电站详情
import 'package:BYM/pages/plant/detail/index.dart';
import 'package:BYM/pages/plant/detail/total_energy.dart';
import 'package:BYM/pages/plant/device/index.dart';
import 'package:BYM/pages/plant/device/mi_detail.dart';
import 'package:BYM/pages/plant/device/mi_list.dart';
import 'package:BYM/pages/plant/index.dart';
import 'package:BYM/pages/plant/more/index.dart';
import 'package:BYM/pages/plant/setting/config/ap/ap_search_device.dart';
import 'package:BYM/pages/plant/setting/config/blue/blue_config_net.dart';
import 'package:BYM/pages/plant/setting/config/blue/blue_search_device.dart';
import 'package:BYM/pages/plant/setting/config/select_config.dart';
import 'package:BYM/pages/plant/setting/index.dart';

//测试
import 'package:BYM/pages/tcp/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 接入点
import 'package:BYM/pages/access_point/info.dart';

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
      page: () => LoginPage(),
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
      page: () => const PlantListPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/PlantEdit',
      page: () => const PlantEdit(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: '/FeedBack',
      page: () => MineFeedback(),
      transition: Transition.rightToLeftWithFade),
  // 电站
  GetPage(
    name: '/PlantDetail',
    page: () => PlantDetail(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/PlantMore',
    page: () => const PlantMore(),
    transition: Transition.rightToLeftWithFade,
  ),

  // 接入点
  GetPage(
    name: '/APInfo',
    page: () => APInfo(),
    transition: Transition.rightToLeftWithFade,
  ),

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
    name: '/TotalEnergy',
    page: () => const TotalEnergy(),
    transition: Transition.rightToLeftWithFade,
  ),

  GetPage(
    name: '/Device',
    page: () => Device(arguments: {}, onHideElements: (shouldHide) {}),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/MIList',
    page: () => MIList(arguments: {}),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/MIDetail',
    page: () => MIDetail(arguments: {}),
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
  GetPage(
    name: '/Setting',
    page: () => Setting(
      arguments: {},
    ),
    transition: Transition.rightToLeftWithFade,
  ),
  //扫码测试
  GetPage(
    name: '/Scan',
    page: () => Scan(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/ByHand',
    page: () => Byhand(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/SelectConfig',
    page: () => SelectConfig(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/SearchDevice',
    page: () => ERBLEListPage(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/ApSearchDevice',
    page: () => ApSearchDevice(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/ApConfigState',
    page: () => ApConfigState(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/ConfigNet',
    page: () => ConfigNet(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/FBlueSearchDevice',
    page: () => FBlueSearchDevice(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/FBlueAddDeviceStep1',
    page: () => FBlueAddDeviceStep1(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/FBlueAddDeviceStep2',
    page: () => FBlueAddDeviceStep2(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/FBlueAddDeviceStep3',
    page: () => FBlueAddDeviceStep3(),
    transition: Transition.rightToLeftWithFade,
  ),
  GetPage(
    name: '/FAddPlant',
    page: () => FAddPlant(),
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
