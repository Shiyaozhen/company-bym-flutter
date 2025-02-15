import 'dart:async';

import 'package:BYM/api/verification.dart';
import 'package:BYM/components/by_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/by_util.dart';

class BindEmail extends StatefulWidget {
  const BindEmail({super.key});

  @override
  _BindEmailState createState() => _BindEmailState();
}

class _BindEmailState extends State<BindEmail> {
  bool isObscure_con = true;
  bool isObscure = true;
  bool canResend = true;
  int countdown = 59;
  Timer? timer;
  //倒计时
  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          canResend = true;
          timer?.cancel();
        }
      });
    });
  }

  void sendCode() {
    if (canResend) {
      setState(() {
        canResend = false;
        countdown = 59;
      });
      startCountdown();
    }
  }

  void tobind() {
    BYRoute.toNamed('/BindSuccess', arguments: {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '绑定邮箱',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF383838),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '邮箱',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '请输入密码',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '请输入密码',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextField(
                obscureText: isObscure,
                decoration: InputDecoration(
                  hintText: '请确认密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '请确认密码',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: TextField(
                obscureText: isObscure_con,
                decoration: InputDecoration(
                  hintText: '请确认密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure_con
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        isObscure_con = !isObscure_con;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '验证码',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '请输入验证码',
                    suffixIcon: Container(
                      width: 120,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            sendCode();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: Text(canResend ? '发送' : '重发($countdown s)',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      color: canResend
                                          ? Color(0xFF5475F8)
                                          : Color(0xFF7989B2),
                                    )),
                          )),
                    ),
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ElevatedButton(
              onPressed: () {
                tobind();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF5475F8)),
                foregroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                minimumSize: MaterialStateProperty.all(Size.fromHeight(45.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              child: Text('绑定',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: const Color(0xFFFFFFFF))),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}




class BindEmailController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String? mask;

  void getCode() async {
    mask = await verificationApi.sendCodeBindEmail(emailController.text)['data']['mask'];

    update();
  }

  void bindEmail() async {}

  @override
  void onInit() {
    getCode();

    super.onInit();
  }
}

class BindEmailPage extends StatelessWidget {
  const BindEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BindEmailController>(
      init: BindEmailController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => BYRoute.back(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('绑定邮箱'),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 50),
          child: ElevatedButton(
            onPressed: () {

            },
            child: const Text('绑定'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('邮箱'),
              const SizedBox(height: 12),
              ByTextField(controller: _.emailController),
              const SizedBox(height: 24),

              const Text('请输入密码'),
              const SizedBox(height: 12),
              ByPasswordField(controller: _.passwordController),
              const SizedBox(height: 24),

              const Text('验证码'),
              const SizedBox(height: 12),
              ByButtonTextField(
                controller: _.codeController,
                suffix: IconButton(
                  icon: const Text('发送'),
                  onPressed: () {
                    _.getCode();
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

