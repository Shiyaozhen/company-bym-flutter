import 'package:BYM/pages/home/index.dart';
import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;
  bool isObscure = true;
  bool _isChecked = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  void _clearTextField() {
    setState(() {
      _controller.clear();
      _showClearButton = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('登录'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/ic_logo.png',
                  width: 60,
                  height: 69,
                ),
              ),
              Center(
                  child: Text(
                'BYM Cloud',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w400),
              )),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(top: 37.0, bottom: 7.0),
                    child: Text('邮箱',
                        style: Theme.of(context).textTheme.displayLarge)),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '请输入您的邮箱',
                      suffixIcon: _showClearButton
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Color(0xFF7989B2)),
                              onPressed: _clearTextField,
                            )
                          : null,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('密码',
                        style: Theme.of(context).textTheme.displayLarge)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  obscureText: isObscure,
                  decoration: InputDecoration(
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
                      hintText: '请输入您的密码'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 51.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            BYRoute.toNamed('/SignUp');
                          },
                          child: Text('立即注册',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Color(0xFF5475F7)))),
                      Container(
                          child: Text('忘记密码?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Color(0xFF5475F7)))),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 26.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          shape: CircleBorder(),
                          activeColor: Color(0xFF5475F7),
                          visualDensity: VisualDensity(
                            horizontal: -4.0,
                            vertical: -4.0,
                          ),
                        ),
                      ),
                      Text('我已阅读并且同意',
                          style: Theme.of(context).textTheme.displayLarge),
                      Text(
                        '《隐私协议》',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: Color(0xFF5475F7)),
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 26.0, top: 26.0),
                  child: ElevatedButton(
                    onPressed: () {
                      BYRoute.off(const HomePage());
                    },
                    child: Text(
                      '登录',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text('体验电站',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF5475F7))),
              )
            ],
          ),
        ));
  }
}
