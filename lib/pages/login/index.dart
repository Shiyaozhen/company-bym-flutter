import 'package:BYM/utils/by_util.dart';
import 'package:BYM/utils/hmac.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _usernameErrorText = '';
  String _passwordErrorText = '';
  // 表单控制器
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toMore() {
    BYRoute.toNamed('/MineMore', arguments: {});
  }

  void toConnect() {
    BYRoute.toNamed('/Connect', arguments: {});
  }

  void toSet() {
    BYRoute.toNamed('/Language', arguments: {});
  }

  void toChangePwd() {
    BYRoute.toNamed('/ChangePwd', arguments: {});
  }
 
  void toBind(){
    BYRoute.toNamed('/BindEmail', arguments: {});
  }
  
  bool _validateInputs() {
    bool isValid = true;

    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameErrorText = '用户名不能为空';
      });
      isValid = false;
    } else {
      setState(() {
        _usernameErrorText = '';
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordErrorText = '密码不能为空';
      });
      isValid = false;
    } else {
      setState(() {
        _passwordErrorText = '';
      });
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    String data = "Hello, World!";
    String key = "MySecretKey";
    String hmacSha256 = HmacUtil.generateHmacSHA256(data, key);
    print("HMAC-SHA256: $hmacSha256");
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(
            //   controller: _usernameController,
            //   decoration: const InputDecoration(labelText: '用户名'),
            // ),
            // TextField(
            //   controller: _passwordController,
            //   decoration: const InputDecoration(labelText: '密码'),
            //   obscureText: true,
            // ),
            // const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // 校验用户名和密码
            //     if (_validateInputs()) {
            //       // 执行登录操作
            //       final username = _usernameController.text;
            //       final password = _passwordController.text;
            //       // TODO: 添加登录逻辑
            //       // 清空输入框
            //       _usernameController.clear();
            //       _passwordController.clear();
            //     }
            //   },
            //   child: const Text('登录'),
            // ),
            ElevatedButton(
              onPressed: () {
                toMore();
              },
              child: const Text('更多'),
            ),
            ElevatedButton(
              onPressed: () {
                toConnect();
              },
              child: const Text('联系我们'),
            ),
            ElevatedButton(
              onPressed: () {
                toSet();
              },
              child: const Text('设置语言'),
            ),
            ElevatedButton(
              onPressed: () {
                toChangePwd();
              },
              child: const Text('修改密码'),
            ),
             ElevatedButton(
              onPressed: () {
                toBind();
              },
              child: const Text('绑定邮箱'),
            ),
          ],
        ),
      ),
    );
  }
}
