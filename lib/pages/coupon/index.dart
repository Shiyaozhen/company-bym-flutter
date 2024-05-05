import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/app.dart';
import 'package:flutter_application_1/pages/blue/index.dart';
import 'package:flutter_application_1/pages/list/index.dart';
import 'package:flutter_application_1/pages/login/index.dart';
import 'package:flutter_application_1/pages/tcp/index.dart';
import 'package:flutter_application_1/pages/toolbar/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 获取列表
   login() async {
  var res = await userApi.login('admin', '123456'); // 替换为实际的用户名和密码
}
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                LoginPage(),
                // Center(
                //     child: Column(children: [
                //   Text(S.of(context).name),
                //   const Divider(),
                //   ElevatedButton(
                //       onPressed: () {
                //         setState(() {
                //           S.load(const Locale('zh', ''));
                //         });
                //       },
                //       child: const Text('切换简体中文')),
                //   ElevatedButton(
                //       onPressed: () {
                //         setState(() {
                //           S.load(const Locale('en', ''));
                //         });
                //       },
                //       child: const Text('切换英文')),
                //        ElevatedButton(
                //       onPressed: () {
                //         login();
                //       },
                //       child: const Text('登录'))
                // ])),
                const SetPages(),
                const TcpPage(),
                const BluetoothPage()
              ],
            ),
          ),
          CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onTabSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
