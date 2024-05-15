import 'package:BYM/pages/home/mine/index.dart';
import 'package:BYM/pages/home/plant/index.dart';
import 'package:BYM/pages/powerstation/detail/index.dart';
import 'package:BYM/pages/powerstation/toolbar/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PowerStationIndex extends StatefulWidget {
  const PowerStationIndex({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<PowerStationIndex> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    //电站名
    final Map<String, dynamic> arguments = Get.arguments;
    final String stationName = arguments['stationName'];
    print(stationName);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                DetailIndex(arguments: arguments),
                PlantIndex(),
                Mine(),
                // const BluetoothPage()
              ],
            ),
          ),
          PlantCustomBottomNavigationBar(
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
