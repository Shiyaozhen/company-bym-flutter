import '../utils/request.dart';

class UserApi {
  // 单例
  static UserApi? _instance;
  // 私有构造函数
  UserApi._internal();
  // 工厂函数
  factory UserApi() => _instance ?? UserApi._internal();
  // 单例getter
  static UserApi? get instance => _instance ?? UserApi._internal();

  // 删
  deleteUser() {
    return Request().request('/api/user/cancel', data: {},);
  }
  // 改
  editUser({
    required String userId,
    required String nickname,
    String phone = '',
    String timezone = 'UTC+00:00'
  }) {
    return Request().request(
      '/api/user/update',
      data: {
        "userId": userId,
        "nickname": nickname,
        "phone": phone,
        "timezone": timezone,
      },
    );
  }

  // 查
  getUser() {
    return Request().request('/api/user/details', data: {});
  }

  // 修改密码
  changePassword({
    required String originalPassword,
    required String targetPassword,
  }) {
    return Request().request(
      '/api/password/change',
      data: {
        "originalPassword": originalPassword,
        "targetPassword": targetPassword,
      },
    );
  }

  // 重设密码
  resetPassword({
    required String email,
    required String mask,
    required String code,
    required String password,
  }) {
    return Request().request(
      '/api/password/reset',
      data: {
        "email": email,
        "mask": mask,
        "code": code,
        "password": password,
      },
    );
  }


  bindEmail({required String email, required String mask, required String code}) {
    return Request().request(
      '/api/email/bind',
      data: {},
    );
  }

  func() {
    return Request().request(
      '',
      data: {},
    );
  }
}

final userApi = UserApi();