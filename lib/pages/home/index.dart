import 'package:BYM/pages/home/mine/index.dart';
import 'package:BYM/pages/home/overview/index.dart';
import 'package:BYM/pages/home/plant/index.dart';
import 'package:BYM/pages/home/toolbar/index.dart';
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
                PlantIndex(),
                Mine(arguments: {},),
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
