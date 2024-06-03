



import 'dart:ui';

import 'package:BYM/utils/by_cmd_util.dart';

class ERChargerData{
    String? account;
    String? currentHeartData;
    
    
    DeviceTypeData? deviceTypeData;

    CPRealTimeData? realTimeData;
    
    CPControlEnableData? controlEnableData;
    
}



class CPRealTimeData{
  CPOPRealTimeData? opData;
  CPTPRealTimeData? tpData;
  bool isOP = false;

  CPRealTimeData(String cmd,this.isOP){
    if(isOP){
      opData = CPOPRealTimeData(cmd);
    }else{
      tpData = CPTPRealTimeData(cmd);
    }
  }

  bool get isCharging{
    if(isOP){
      return opData?.status == "6";
    }else{
      return tpData?.status == "6";
    }
    

  }

 





}




class CPOPRealTimeData{
  String? current;
  String? voltage;
  String? power;
  String? degress;
  String? temp;
  String? status;
  String? timeChargingStatus;
  String? timeChargingStartT;
  String? timeChargingEndT;
  String? currentAllowMaxCurrent;
  String? maxDegress;
  String? inWeeklyEnable;
  String? monthlyRestictEnable;
  String? dlbExternRestEnable;


  CPOPRealTimeData(String cmd){
    if(cmd.isNotEmpty){
      current = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    

    if(cmd.isNotEmpty){
      voltage = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    
    if(cmd.isNotEmpty){
      power = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){
      degress = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){
      temp = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }


    if(cmd.isNotEmpty){
      status = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }


    if(cmd.isNotEmpty){
      timeChargingStatus = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      var h = cmd.substring(0,2).convert16_10.fixSize(2);
      var m = cmd.substring(2,4).convert16_10.fixSize(2);
      var s = cmd.substring(4,6).convert16_10.fixSize(2);

      timeChargingStartT = h + m + s;

      cmd = cmd.replaceRange(0, 6, '');
    }


    if(cmd.isNotEmpty){
      var h = cmd.substring(0,2).convert16_10.fixSize(2);
      var m = cmd.substring(2,4).convert16_10.fixSize(2);
      var s = cmd.substring(4,6).convert16_10.fixSize(2);

      timeChargingEndT = h + m + s;

      cmd = cmd.replaceRange(0, 6, '');
    }

    if(cmd.isNotEmpty){
      currentAllowMaxCurrent = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      maxDegress = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      inWeeklyEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      monthlyRestictEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      dlbExternRestEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }




  }


}






class CPTPRealTimeData{
  String? currentA;
  String? currentB;
  String? currentC;
  String? voltageA;
  String? voltageB;
  String? voltageC;
  String? power;
  String? degress;
  String? temp;
  String? status;
  String? timeChargingStatus;
  String? timeChargingStartT;
  String? timeChargingEndT;
  String? currentAllowMaxCurrent;
  String? maxDegress;
  String? inWeeklyEnable;
  String? monthlyRestictEnable;
  String? dlbExternRestEnable;

  CPTPRealTimeData(String cmd){
    if(cmd.isNotEmpty){
      currentA = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      currentB = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      currentC = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      voltageA = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){
      voltageB = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){
      voltageC = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }


    if(cmd.isNotEmpty){
      power = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){
      degress = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){
      temp = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }


    if(cmd.isNotEmpty){
      status = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }


    if(cmd.isNotEmpty){
      timeChargingStatus = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      var h = cmd.substring(0,2).convert16_10.fixSize(2);
      var m = cmd.substring(2,4).convert16_10.fixSize(2);
      var s = cmd.substring(4,6).convert16_10.fixSize(2);

      timeChargingStartT = h + m + s;

      cmd = cmd.replaceRange(0, 6, '');
    }


    if(cmd.isNotEmpty){
      var h = cmd.substring(0,2).convert16_10.fixSize(2);
      var m = cmd.substring(2,4).convert16_10.fixSize(2);
      var s = cmd.substring(4,6).convert16_10.fixSize(2);

      timeChargingEndT = h + m + s;

      cmd = cmd.replaceRange(0, 6, '');
    }

    if(cmd.isNotEmpty){
      currentAllowMaxCurrent = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      maxDegress = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      inWeeklyEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      monthlyRestictEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      dlbExternRestEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }




  }




}







class DeviceTypeData{
  String? devciceTypeCode;
  String?  pileVersion;
  String? softWare;
  String? hardWare;



  DeviceTypeData(String cmd){
    
    if(cmd.isNotEmpty){
      devciceTypeCode = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }
    


    if(cmd.isNotEmpty){
      pileVersion = cmd.substring(0,40).convert16_text;
      cmd = cmd.replaceRange(0, 40, '');
    }


    if(cmd.isNotEmpty){
      softWare = cmd.substring(0,4).convert16_version;
      cmd = cmd.replaceRange(0, 4, '');
    }


    if(cmd.isNotEmpty){
      hardWare = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }





  }


}



class CPControlEnableData{
  String? rfidEnable;
  String? appControlEnable;
  String? dlbEnable;
  String? grandDetectEnable;
  String? overTemp;
  String? maxCurrent;
  String? dlbMode;
  String? pvDLBMaxCurrent;
  List<String> weeklyEnable = [];

  String? startH;
  String? startM;
  String? endH;
  String? endM;
  String? monthMaxDegress;
  String? emergencyStopProtectionEnable;
  String? dlbExtmeModeEnable;
  String? nightFullSpeedEnable;
  String? compatibleModeEnable;
  String? autoFullSpeedStartH;
  String? autoFullSpeedEndH;




  bool get isDLBEnable{
    return dlbEnable == '1';
  }


  bool get isGrandDetectEnable{
    return grandDetectEnable == '1';
  }


  bool get isExrmeMode{
    return dlbExtmeModeEnable == '1';
  }

  String get pvMaxCurrent{
    return pvDLBMaxCurrent ?? "";
  }


  bool? get autoModeEnabel{
    if(nightFullSpeedEnable != null){
      return nightFullSpeedEnable == "1";
    }else{
      return null;
    }
    
  }










CPControlEnableData(String cmd){
    
    if(cmd.isNotEmpty){
      rfidEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }
    
    if(cmd.isNotEmpty){
      appControlEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      dlbEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      grandDetectEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){
      overTemp = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }


    if(cmd.isNotEmpty){ // 最大电流
      maxCurrent = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }
    

    if(cmd.isNotEmpty){ // DLB模式
      dlbMode = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      pvDLBMaxCurrent = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }



    if(cmd.isNotEmpty){ // 周一到周日使能
      String content = cmd.substring(0,2).convert16_2;
      List<String> ret = [];
      for(int i =1;i<content.length;i++){
        ret.add(content.substring(i ,i+1));
      }
      weeklyEnable = ret;

      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      startH = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }
    
    if(cmd.isNotEmpty){ //
      startM = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      endH = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      endM = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      monthMaxDegress = cmd.substring(0,4).convert16_10;
      cmd = cmd.replaceRange(0, 4, '');
    }

    if(cmd.isNotEmpty){ //
      emergencyStopProtectionEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }


    if(cmd.isNotEmpty){ //
      dlbExtmeModeEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      nightFullSpeedEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      compatibleModeEnable = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }



    if(cmd.isNotEmpty){ //
      autoFullSpeedStartH = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

    if(cmd.isNotEmpty){ //
      autoFullSpeedEndH = cmd.substring(0,2).convert16_10;
      cmd = cmd.replaceRange(0, 2, '');
    }

  }








}


