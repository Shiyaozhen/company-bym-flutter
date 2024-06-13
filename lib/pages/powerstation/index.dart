import 'package:BYM/pages/home/mine/index.dart';
import 'package:BYM/pages/home/plant/index.dart';
import 'package:BYM/pages/powerstation/detail/index.dart';
import 'package:BYM/pages/powerstation/device/index.dart';
import 'package:BYM/pages/powerstation/setting/index.dart';
import 'package:BYM/pages/powerstation/toolbar/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PowerStationIndex extends StatefulWidget {
  const PowerStationIndex({super.key});

  @override
  State<PowerStationIndex> createState() => _PowerStationIndexState();
}

class _PowerStationIndexState extends State<PowerStationIndex> {
  int selectedIndex = 0;
  bool shouldHideElements = false;

  void toggleHideElements(bool shouldHide) {
    setState(() {
      shouldHideElements = shouldHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String stationName = arguments['stationName'];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                DetailIndex(
                  arguments: {},
                ),
                Device(
                  arguments: {'stationName': stationName},
                  onHideElements: toggleHideElements,
                ),
                Setting(arguments: {},
                ),
              ],
            ),
          ),
          if (!shouldHideElements)
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
