import 'package:flutter_application_1/pages/coupon/index.dart';
import 'package:flutter_application_1/pages/list/index.dart';
import 'package:flutter_application_1/pages/tcp/index.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(name: '/Home', page: () => HomePage()),
  GetPage(name: '/SetPages', page: () => SetPages()),
  GetPage(name: '/TcpPage', page: () => TcpPage())
];
