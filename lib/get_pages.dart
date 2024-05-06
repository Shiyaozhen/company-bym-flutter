import 'package:BYM/pages/coupon/index.dart';
import 'package:BYM/pages/list/index.dart';
import 'package:BYM/pages/tcp/index.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(name: '/Home', page: () => HomePage()),
  GetPage(name: '/SetPages', page: () => SetPages()),
  GetPage(name: '/TcpPage', page: () => TcpPage())
];
