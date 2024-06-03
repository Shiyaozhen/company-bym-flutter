
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/physics.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:BYM/utils/Device.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';
import 'package:get/get.dart';



class BYBLEUtil{


  BYBLEUtil._internal();
	
	factory BYBLEUtil() => _instance;

	static final BYBLEUtil _instance = BYBLEUtil._internal();



  // MARK:  - 
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;



  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;


  void init(){

  

  }


  


  // 扫描设备，
  Future scan(int second) async {
    await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;

    try {

      _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) { // 这里会反复被回调
        _scanResults = results;
      }, onError: (e) {
        BYLog.d('Scan Error:,${e}');
      });


      await FlutterBluePlus.startScan(timeout:Duration(seconds: second));

    } catch (e) {
      BYLog.d("Start Scan Error:${e}");
    }
    
  }


  







  



}