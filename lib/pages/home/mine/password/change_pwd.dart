import 'package:BYM/api/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../get_pages.dart';

class ChangePasswordController extends GetxController {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController passwordController3 = TextEditingController();

  void changePassword() async {
    await userApi.changePassword(originalPassword: passwordController1.text, targetPassword: passwordController2.text);
  }
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => BYRoute.back()),
          title: const Text('修改密码'),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 50),
          child: ElevatedButton(
            onPressed: () {
              _.changePassword();
            },
            child: const Text('保存'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('旧密码'),
              const SizedBox(height: 12),
              PasswordField(controller: _.passwordController1),
              const SizedBox(height: 24),

              const Text('请输入密码'),
              const SizedBox(height: 12),
              PasswordField(controller: _.passwordController2),
              const SizedBox(height: 24),

              const Text('请再次输入密码'),
              const SizedBox(height: 12),
              PasswordField(controller: _.passwordController3),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordField({
    super.key,
    required this.controller,
    this.hintText = '',
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xFF7989B2),
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      onChanged: (text) {},
      onSubmitted: (text) {
        print('提交$text');
      },
    );
  }
}


