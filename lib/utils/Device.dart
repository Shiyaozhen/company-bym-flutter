import 'package:BYM/utils/ERChargerData.dart';
import 'package:BYM/utils/by_cmd_util.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';



enum DeviceType {
  unknow(desc: '未知', code: -1),
  chargerOP(desc: '单相智能款', code: 0),
  chargerTP(desc: '三相智能款', code: 1),
  chargerOCPPOP(desc: 'OCPP单相', code: 2),
  chargerOCPPTP(desc: 'OCPP三相', code: 3),
  chargerOCPPOPTG(desc: 'OCPP三相', code: 4),
  chargerOCPPTPTG(desc: 'OCPP三相', code: 5),
  chargerLCDOP(desc: 'LCD单相', code: 6),
  chargerLCDTP(desc: 'LCD三相', code: 7),
  eRouter(desc: '能量路由器', code: 100),
  microInverter(desc: '微型逆变器', code: 200);


  const DeviceType({required this.desc, required this.code});
  final String desc;
  final int code;





}



class Device{

  int? deviceId;
  String? remark;
  String? account;
  String? currentChooseGun;
  String? pileversion ;
  String? connectType;
  String? deviceType;
  String? homewifissid;
  String? pass;
  String? software;
  String? hardware;
  String? binData; // 固件




  ScanResult? bleScanRet;
  ERChargerData chargeGetData = ERChargerData();
  

  Device({this.remark,this.account,this.currentChooseGun,this.pileversion,this.connectType,this.deviceType,this.homewifissid,this.pass,this.software,this.hardware,this.binData,this.bleScanRet});


  Device.fromJson(dynamic json){
    deviceId = json['deviceId'];
    remark = json['remark'];
    account = json['account'];
    currentChooseGun = json['currentChooseGun'];
    pileversion = json['pileversion'];
    connectType = json['connectType'];
    deviceType = json['deviceType'];
    // homewifissid = json['homewifissid'];
    pass = json['pass'];
    software = json['software'];
    hardware = json['hardware'];
    binData = json['binData'];

  }


  Map<String,dynamic> toJson(){
    final map = <String,dynamic>{};
    // map['deviceId'] = deviceId;
    map['remark'] = remark;
    map['account'] = account;
    map['currentChooseGun'] = currentChooseGun;
    map['pileversion'] = pileversion;
    map['connectType'] = connectType;
    map['deviceType'] = deviceType;
    // map['homewifissid'] = homewifissid;
    map['pass'] = pass;
    map['software'] = software;
    map['hardware'] = hardware;
    map['binData'] = binData;
    return map;
  }



  //  get###########################################

  DeviceType get devcieEnumType{
    if(deviceType == null){
      return DeviceType.unknow;
    }

    int deviceTypeS = int.parse(deviceType!);
    

    if(deviceTypeS == 0){
      return DeviceType.chargerOP;
    }else if(deviceTypeS == 1){
      return DeviceType.chargerTP;
    }else if(deviceTypeS == 2){
      return DeviceType.chargerOCPPOP;
    }
    else if(deviceTypeS == 3){
      return DeviceType.chargerOCPPTP;
    }
    else if(deviceTypeS == 4){
      return DeviceType.chargerOCPPOPTG;
    }
    else if(deviceTypeS == 5){
      return DeviceType.chargerOCPPTPTG;
    }
    else if(deviceTypeS == 6){
      return DeviceType.chargerLCDOP;
    }else if(deviceTypeS == 7){
      return DeviceType.chargerLCDTP;
    }else if(deviceTypeS == 100){
      return DeviceType.eRouter;
    }else if(deviceTypeS == 7){
      return DeviceType.microInverter;
    }
    else{
      return DeviceType.unknow;
    }

  }



  bool get isBLEConnect{
    return connectType == '0';
  }


  bool get isNomalIntellec{
    if(devcieEnumType == DeviceType.chargerOP || devcieEnumType == DeviceType.chargerTP){
        return true;
    }else{
        return false;
    }
  }


  bool get isOCPP{
    if(devcieEnumType == DeviceType.chargerOCPPOP || devcieEnumType == DeviceType.chargerOCPPTP || devcieEnumType == DeviceType.chargerOCPPOPTG||devcieEnumType == DeviceType.chargerOCPPTPTG){
        return true;
    }else{
        return false;
    }
  }


  bool get isLCD{
    if(devcieEnumType == DeviceType.chargerLCDOP || devcieEnumType == DeviceType.chargerLCDTP){
        return true;
    }else{
        return false;
    }
}


  bool get isMI{
    if(devcieEnumType == DeviceType.microInverter){
        return true;
    }else{
        return false;
    }
  }
  

  bool get isER{
    if(devcieEnumType == DeviceType.eRouter){
        return true;
    }else{
        return false;
    }
  }

  bool get isCharger{
    if(isNomalIntellec || isOCPP || isLCD){
      return true;
    }else{
      return false;
    }
  }


  bool get isSingle{
    if(devcieEnumType == DeviceType.chargerOP || devcieEnumType == DeviceType.chargerLCDOP || devcieEnumType == DeviceType.chargerOCPPOP || devcieEnumType == DeviceType.chargerOCPPOPTG){
        return true;
    }else{
        return false;
    }
  }


  bool get isTwoGun{
    if(devcieEnumType == DeviceType.chargerOCPPOPTG || devcieEnumType == DeviceType.chargerOCPPTPTG){
        return true;
    }else{
        return false;
    }
  }



  @override
  String toString() {
    String content = "deviceId:${deviceId}" 
      + "\nremark:" + (remark ?? '')
      + "\naccount:" + (account ?? '')
      + "\ncurrentChooseGun:" + (currentChooseGun ?? "")
      + "\npileversion:" + (pileversion ?? "")
      + "\nconnectType:" + (connectType ?? "")
      + "\ndeviceType:" + (deviceType ?? "")
      + "\nhomewifissid:" + (homewifissid ?? "")
      + "\npass:" + (pass ?? "")
      + "\nsoftware:" + (software ?? "")
      + "\nhardware:" + (hardware ?? "")
      + "\nbinData:" + (binData  ?? "")
      + "\nbleScanRet:" + (bleScanRet?.device.advName ?? "无");

    return content;
  }















}