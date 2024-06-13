import 'package:BYM/get_pages.dart';
import 'package:BYM/utils/storage.dart';
import 'package:dio/dio.dart';

import '../utils/request.dart';

class AppApi {
  // 单例
  static AppApi? _instance;
  // 私有构造函数
  AppApi._internal();
  // 工厂函数
  factory AppApi() => _instance ?? AppApi._internal();
  // 单例getter
  static AppApi? get instance => _instance ?? AppApi._internal();

  /// 登录
  login(String username, String password) async {
    var res = await Request().request(
      "/api/password/login",
      method: DioMethod.post,
      data: {"username": username, "password": password},
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        extra: {"isToken": false},
      ),
    );

    if(res['status'] == 200) {
      await Storage.instance!.setString('token', res['data']['token']);
      await Storage.instance!.setString('username', username);
      await Storage.instance!.setString('password', password);

      BYRoute.toNamed('/Home');
    }
  }
}

final appApi = AppApi();
