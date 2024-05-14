import 'package:BYM/api/app.dart';
import 'package:BYM/pages/home/mine/index.dart';
import 'package:BYM/pages/home/overview/index.dart';
import 'package:BYM/pages/home/toolbar/index.dart';
import 'package:BYM/pages/list/index.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 获取列表
  login() async {
    // var res = await userApi.login('admin', '123456'); // 替换为实际的用户名和密码
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: const [
                OverViewIndex(),
                SetPages(),
                Mine(),
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
                const PlantIndex(),
                const MineIndex(),
                // const BluetoothPage()
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
