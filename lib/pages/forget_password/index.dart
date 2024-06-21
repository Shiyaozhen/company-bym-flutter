import 'package:BYM/api/verification.dart';
import 'package:BYM/components/by_input_field.dart';
import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController maskController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  void sendCode() async {
    var res = await verificationApi.sendCodeForgetPassword(emailController.text);
  }
  void resetPassword() async {

  }
}

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ForgetPasswordController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => BYRoute.back(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('忘记密码'),
              const SizedBox(height: 12),
              const Text('输入您的电子邮箱， 我们将向您发送验证码.'),
              const SizedBox(height: 40),

              const Text('邮箱'),
              const SizedBox(height: 12),
              ByTextField(controller: _.emailController),
              const SizedBox(height: 20),

              const Text('请输入密码'),
              const SizedBox(height: 12),
              ByPasswordField(controller: _.passwordController),
              const SizedBox(height: 20),

              const Text('请确认密码'),
              const SizedBox(height: 12),
              ByPasswordField(controller: _.maskController),
              const SizedBox(height: 20),

              const Text('验证码'),
              const SizedBox(height: 12),
              ByButtonTextField(
                controller: _.codeController,
                suffix: IconButton(
                  onPressed: () {
                    _.sendCode();
                  },
                  icon: const Text('发送'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
