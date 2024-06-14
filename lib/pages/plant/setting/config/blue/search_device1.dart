import 'dart:async';

import 'package:BYM/get_pages.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SearchDevice extends StatefulWidget {
  const SearchDevice({super.key});

  @override
  State<SearchDevice> createState() => _SearchDeviceState();
}

class _SearchDeviceState extends State<SearchDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
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
      body: Container(
        child: Column(
          children: [
            SearchTipWidgetState(),
            // SearchIconWidgetState(),
            SearchListWidget()
          ],
        ),
      ),
    );
  }
}

//搜索提示
class SearchTipWidgetState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 22.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '扫描附近蓝牙设备(请确认设备已上电)',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 16.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '持续自动搜索中...',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Color(0xFF7989B2)),
            ),
          )
        ],
      ),
    );
  }
}

//搜寻中
class SearchIconWidgetState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 120,
        ),
        Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
        SizedBox(
          height: 27.0,
        ),
        Text(
          '请将手机尽量靠近要添加的设备',
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: Color(0xFF7989B2)),
        )
      ],
    ));
  }
}

//已搜寻列表
class SearchListWidget extends StatefulWidget {
  @override
  _SearchListWidgetState createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  List<ScanResult> _scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  List<String> items = ['40010107', '20010107', '10010107', '90010107'];
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      List<ScanResult> temp =
          results.where((e) => _isRegDeviceName(e.device.advName)).toList();
      _scanResults = temp;
      print(_scanResults);
      if (mounted) {
        setState(() {});
      }
    });

    scanDevice();
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 18, right: 18),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              print(item);
              BYRoute.toNamed('/ConfigNet', arguments: {'MIId': item});
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F7FF),
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: 150,
              height: 120,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: item.substring(0, 1) == '4',
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'assets/ic_mi_four.png',
                          width: 70,
                          height: 54,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: item.substring(0, 1) == '2',
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'assets/ic_mi_two.png',
                          width: 84,
                          height: 54,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: item.substring(0, 1) == '1',
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Image.asset(
                          'assets/ic_mi_one.png',
                          width: 51,
                          height: 64,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: item.substring(0, 1) == '9',
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Image.asset(
                          'assets/ic_mi_nine.png',
                          width: 70,
                          height: 54,
                        ),
                      ),
                    ),
                    Text(item)
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

bool _isRegDeviceName(String deviceName) {
  return (isEVSE(deviceName) || isMI(deviceName) || isER(deviceName));
}

bool isEVSE(String deviceName) {
  return deviceName.startsWith('EVSE');
}

bool isER(String deviceName) {
  return deviceName.startsWith('ER');
}

bool isMI(String deviceName) {
  return deviceName.startsWith('MI');
}

Future scanDevice() async {
  await FlutterBluePlus.adapterState
      .where((val) => val == BluetoothAdapterState.on)
      .first;
  BYLog.d('开始扫描');

  try {
    await FlutterBluePlus.startScan();
  } catch (e) {
    BYLog.d("Start Scan Error:${e}");
  }
  // if (mounted) { // 组件数建立完善后才能更新UI
  //   setState(() {});
  // }
}
