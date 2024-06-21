import '../utils/request.dart';

class VerificationApi {
  // 单例
  static VerificationApi? _instance;
  // 私有构造函数
  VerificationApi._internal();
  // 工厂函数
  factory VerificationApi() => _instance ?? VerificationApi._internal();
  // 单例getter
  static VerificationApi? get instance => _instance ?? VerificationApi._internal();


  // 忘记密码 验证码
  sendCodeForgetPassword(String email) {
    return Request().request(
      '/api/password/forget/verify',
      data: {
        "email": email
      },
    );
  }

  // 绑定邮箱 验证码
  sendCodeBindEmail(String email) {
    return Request().request(
      '/api/email/bind/verify',
      data: {
        "email": email,
      },
    );
  }

  func() {
    return Request().request(
      '',
      data: {},
    );
  }
}

final verificationApi = VerificationApi();