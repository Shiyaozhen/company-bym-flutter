import 'dart:math';
import 'dart:ui';
import 'dart:async';
import 'package:BYM/get_pages.dart';
import 'package:BYM/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:BYM/utils/ERApp.dart';
// import 'package:ZBOX_flutter/pages/device_detail_page/charger_detail_page/ERChargerDetailTabPage.dart';
import 'package:BYM/utils/BLEManager.dart';
// import 'package:BYM/util/BYDBHealper.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:BYM/utils/Device.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FBlueSearchDevice extends StatefulWidget {
  FBlueSearchDevice({
    super.key,
  });

  @override
  State<FBlueSearchDevice> createState() => _FBlueSearchDeviceState();
}

class _FBlueSearchDeviceState extends State<FBlueSearchDevice> {
  List<ScanResult> _scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      BYLog.d('蓝牙扫描结果${results}');
      List<ScanResult> temp =
          results.where((e) => _isRegDeviceName(e.device.advName)).toList();
      _scanResults = temp;
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
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_horiz,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Visibility(
              visible: _scanResults.length > 0,
              child: Container(
                height: MediaQuery.of(context).size.height - 90,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '扫描附近蓝牙设备(请确认设备已上电)',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '持续自动搜索中...',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF7989B2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          child: GridView.builder(
                            // shrinkWrap: true, // 必须有，因为长度没写
                            itemCount: _scanResults.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        ((MediaQuery.of(context).size.width -
                                                    16 * 3) /
                                                2) /
                                            108,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16),
                            itemBuilder: (BuildContext context, int index) {
                              return cellForItem(index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: _scanResults.length == 0,
                child: Container(
                    height: MediaQuery.of(context).size.height-150,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 18.0,top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('扫描附近蓝牙设备(请确认设备已上电)',style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),),
                          ),
                        ),
                          Container(
                          padding: EdgeInsets.only(left: 18.0,top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('持续自动搜索中...',style: TextStyle(fontSize: 14.0,color: Color(0xFF7989B2)),),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 80),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/ic_scan_blue.gif'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '请将手机尽量靠近要添加的设备',
                            style: TextStyle(color: Color(0xFF7989B2)),
                          ),
                        )
                      ],
                    )))
          ],
        ));
  }

  Widget cellForItem(int i) {
    ScanResult ret = _scanResults[i];
    return GestureDetector(
      onTap: () {
        connectDevice(i);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 160.0,
          height: 140.0,
          color: Color(0xFFF5F7FF),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // BYSVG.svg('assets/er_device_charger_one_gun_face.svg'),
                    Visibility(
                        visible: ret.device.advName
                                .substring(ret.device.advName.length - 8)
                                .substring(0, 1) ==
                            'A',
                        child: Image.asset(
                          'assets/ic_mi_one.png',
                          width: 70,
                          height: 50,
                        )),
                    Visibility(
                        visible: ret.device.advName
                                .substring(ret.device.advName.length - 8)
                                .substring(0, 1) ==
                            'C',
                        child: Image.asset(
                          'assets/ic_mi_four.png',
                          width: 70,
                          height: 50,
                        )),
                    Visibility(
                        visible: ret.device.advName
                                .substring(ret.device.advName.length - 8)
                                .substring(0, 1) ==
                            '9',
                        child: Image.asset(
                          'assets/ic_mi_four.png',
                          width: 70,
                          height: 50,
                        ))
                  ],
                ),
                // Text('${deviceTypeDesc(ret.device.advName)}'),
                Text(
                    '${deviceCode(ret.device.advName.substring(ret.device.advName.length - 8))}'),
              ],
            ),
          ),
        ),
      ),
    );
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
    if (mounted) {
      // 组件数建立完善后才能更新UI
      setState(() {});
    }
  }

  Future<void> onRefresh() async {}

  Future connectDevice(int index) async {
    ScanResult ret = _scanResults[index];

    Device device = Device(
        account: ret.device.advName,
        connectType: '0',
        bleScanRet: ret,
        pass: "123456",
        deviceType: '0');

    EasyLoading.show(status: 'loading...');
    bool isSuc = await BLEManager().connectDevice(device);

    if (isSuc) {
      EasyLoading.showToast('连接成功');
      // BYRoute.toNamed('/FBlueAddDeviceStep1');
      BLEManager().getDeviceType((isSuc, errCode, data) {
        BLEManager().startHeart();
        BYRoute.toNamed('/FBlueAddDeviceStep1');
      });
    } else {
      EasyLoading.showToast('连接失败');
    }
  }

  // MARK:-  help func
  bool _isRegDeviceName(String deviceName) {
    return (isMI(deviceName));
  }

  String deviceCode(String deviceName) {
    var ret = deviceName.split('-');
    if (ret.length == 2) {
      return ret.last;
    } else {
      return deviceName;
    }
  }

  String deviceTypeDesc(String deviceName) {
    if (isEVSE(deviceName)) {
      return '充电桩';
    } else if (isER(deviceName)) {
      return '能量路由器';
    } else {
      return '微型逆变器';
    }
  }

  bool isEVSE(String deviceName) {
    return deviceName.startsWith('EVSE');
  }

  bool isER(String deviceName) {
    return deviceName.startsWith('ER');
  }

  bool isMI(String deviceName) {
    return deviceName.startsWith('MI') ;
  }
}
