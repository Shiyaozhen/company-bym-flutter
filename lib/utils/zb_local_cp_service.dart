import 'package:BYM/utils/BLEManager.dart';
import 'package:BYM/utils/by_cmd_util.dart';







class ZBLocalCPService{

  static String devicePass(){
    return BLEManager().connectingDevice!.pass!;
  }



  // 获取控制使能
  static Future getControlEnable(CompleteCallback complete) async{
    String cmd = BYCmdUtil.makeSendCMD(113, devicePass().intValue, '',isHeartCmd: false);
  
    await BLEManager().sendCmdAndStartTimet(cmd, complete);
  }


  // 设置DLB配置
  static Future setDLBMode(bool isDLBEnable,bool isExtremMode,String pvMaxCurrent,bool? autoModeEnable,String? autoModeStartH,String? autoModeEndH,CompleteCallback complete) async{
    String dlbEnableS = isDLBEnable ? "01" : "00";
    String extremeModeS = isExtremMode ? "01" : "00";
    String pvMaxCurrentS = pvMaxCurrent.convert10_16;
    String autoModeEnableS = "";
    if( autoModeEnable != null){
      autoModeEnableS = autoModeEnable ? "01" : "00";
    }
    String  startH = "";
    if(autoModeStartH != null){
      startH = autoModeStartH.convert10_16.fixSize(2);
    }

    String  endH = "";
    if(autoModeEndH != null){
      endH  = autoModeEndH.convert10_16.fixSize(2);
    }

    String content = dlbEnableS + extremeModeS + pvMaxCurrentS + autoModeEnableS + startH + endH;



    String cmd = BYCmdUtil.makeSendCMD(107, devicePass().intValue, content,isHeartCmd: false);


    await BLEManager().sendCmdAndStartTimet(cmd, complete);
  }






// 接地检测是否启用
static Future  setGrandDetectEnable(bool isGrandDetectEnable,CompleteCallback complete) async{
  String isGrandDetectEnableS = isGrandDetectEnable ? "01" : "00";
  String content = isGrandDetectEnableS;

  String cmd = BYCmdUtil.makeSendCMD(108, devicePass().intValue, content,isHeartCmd: false);
  await BLEManager().sendCmdAndStartTimet(cmd, complete);
}







}