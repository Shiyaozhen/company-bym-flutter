
import 'dart:math';
import 'dart:ui';
import 'dart:async';
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



class ERBLEListPage extends StatefulWidget {
  ERBLEListPage({
    super.key,
  });

  @override
  State<ERBLEListPage> createState() => _ERBLEListPageState();
}


class _ERBLEListPageState extends State<ERBLEListPage> {
 
  List<ScanResult> _scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
 
  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      print(results);
      List<ScanResult> temp =  results.where((e) => _isRegDeviceName(e.device.advName)).toList();
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
            onPressed: () {
            },
          ),

        ],
      ),
      body: 
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              children: [
                Expanded(
                  flex: 1,
                  child: RefreshIndicator(
                    onRefresh: onRefresh,
                    child: GridView.builder(
                      // shrinkWrap: true, // 必须有，因为长度没写
                      itemCount: _scanResults.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:  ((MediaQuery.of(context).size.width - 16 * 3) / 2 ) / 108,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16
                      ),
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
    );
  }

  Widget cellForItem(int i) {
    ScanResult ret = _scanResults[i];


    return GestureDetector(
      onTap: () {
        connectDevice(i);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Color(0xFFF4F6FA),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BYSVG.svg('assets/er_device_charger_one_gun_face.svg'),

                    Icon(
                      Icons.adb_sharp
                    ),
                  ],
                ),
                Text('${deviceTypeDesc(ret.device.advName)}'),
                Text('${deviceCode(ret.device.advName)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future scanDevice() async {
    await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;
    BYLog.d('开始扫描');

    try {
      await FlutterBluePlus.startScan();
    } catch (e) {
      BYLog.d("Start Scan Error:${e}");
    }
    if (mounted) { // 组件数建立完善后才能更新UI
      setState(() {});
    }

  }


  Future<void> onRefresh()async{

  }




  Future connectDevice(int index)async{
    ScanResult ret = _scanResults[index];


    Device device = Device(account:ret.device.advName,connectType:'0',bleScanRet: ret,pass: "123456",deviceType:'0');
    
    // EasyLoading.show(status: 'loading...');
    bool isSuc = await  BLEManager().connectDevice(device);

    if(isSuc){
      print('1');
      // bool ret  = await BYDBHealper.getInstance().insert(device);

      if(true){
        // ERApp().allDevices.value = await BYDBHealper.getInstance().queryAll();

    
        // EasyLoading.showToast('连接成功'); 

        // BLEManager().getDeviceType((isSuc, errCode, data) {
        //   BLEManager().startHeart();
        //   Get.off(ERChargerDetailTabPage());
        // });


      }else{
        EasyLoading.showToast('插入数据失败');
      }
      
    }else{
      EasyLoading.showToast('连接失败');
    }

  }



  // MARK:-  help func 
  bool _isRegDeviceName(String deviceName){
  
    return (isEVSE(deviceName) || isMI(deviceName) || isER(deviceName));
  
  }


  String deviceCode(String deviceName){
    var ret = deviceName.split('-');
    if(ret.length == 2){
      return ret.last;
    }else{
      return deviceName;
    }
  }

  String deviceTypeDesc(String deviceName){
    if(isEVSE(deviceName)){
      return '充电桩';
    }else if(isER(deviceName)){
      return '能量路由器';
    }else{
      return '微型逆变器';
    }
  }


  bool isEVSE(String deviceName){
    return deviceName.startsWith('EVSE');
  }

  bool isER(String deviceName){
    return deviceName.startsWith('ER');
  }

  bool isMI(String deviceName){
    return deviceName.startsWith('MI');
  }










}