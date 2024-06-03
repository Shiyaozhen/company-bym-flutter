
import 'package:BYM/base/by_base_page_getx.dart';
import 'package:flutter/material.dart';
import 'package:BYM/utils/BYDBHealper.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:BYM/utils/Device.dart';
import 'package:BYM/utils/ERChargerData.dart';
import 'package:get/get.dart';




class ERApp extends BYBasePageGontroller{

  ERApp._internal();
	
	factory ERApp() => _instance;

	static final ERApp _instance = ERApp._internal();


  


  Rx<Device> connectingDevice =  Device().obs;


  var allDevices = <Device>[].obs; // 

  


  void updateConnectingDevice(Device device){
    connectingDevice.value = device;
    BYLog.d('正在连接的设备数据更新${device}');
    connectingDevice.refresh();
  }
  

  





}