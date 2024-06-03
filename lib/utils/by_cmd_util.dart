


import 'package:BYM/utils/ERApp.dart';
import 'package:BYM/utils/BLEManager.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:BYM/utils/ERChargerData.dart';
import 'package:flutter/foundation.dart';

class BYCmdUtil{

  static const prefix = '55aa';


  static String makeSendCMD(int cmdId,int pass,String content,{bool isHeartCmd = false}){

    String ret = prefix; // 55aa
    String msgId = getMsgId(cmdId,isHeartCmd: isHeartCmd);
    String passHex = pass.toRadixString(16).fixSize(8);
    String cmdIdS = cmdId.toRadixString(16).fixSize(2); // 操作命令
    int clength =  ((prefix.length + msgId.length + passHex.length + cmdIdS.length + content.length + 2 + 2) / 2).toInt(); // 校验
    String lengthS = clength.toRadixString(16).fixSize(2); // 操作命令

    ret = ret + msgId + lengthS + passHex + cmdIdS + content;

    String checkSum = ret.checkSum();

    return ret + checkSum;
  }




  // 本来想msgId里面放一个随机数进去的，但算了，有点麻烦
  static String getMsgId(int cmdId,{bool isHeartCmd = false,String gunId = '0'}){
    String cmdIdHex =cmdId.toRadixString(16).fixSize(2);
    String flag = isHeartCmd ? '1' : '0';
    String ret = flag + cmdIdHex + gunId; 
    return ret;
  }


  static int getRecMsgType(String cmd){
    if(cmd.length < 12){
      BYLog.e('命令不符合规范${cmd}');
      return -1;
    }else{
      int ret = cmd.substring(10,12).convert16_10.intValue;
      return ret;
    }
    
  }




  static void handleCPCmd(String cmd){
    if(cmd.length < 14){
      BYLog.e('接收到的数据不符合规范${cmd}');
      return;
    }

    int msgId = getRecMsgType(cmd);

    String content = cmd.substring(12,cmd.length - 2);

    if(msgId == 113){ // 读取控制使能
      BYLog.d('读取设备使能${cmd}');

      BLEManager().connectingDevice!.chargeGetData.controlEnableData = CPControlEnableData(content);    
      ERApp().updateConnectingDevice(BLEManager().connectingDevice!);
    }else if(msgId == 112){ // 读取实时数据
      BYLog.d('读取实时数据${cmd}');

     

    }else{

    }

  


  }


    
}












extension  BYConvert on String{
  

  /// 返回校验和
  String checkSum(){

    int total = 0;
    int len = length;
    if(len % 2 != 0){
        return "00";
    }
    
    
    for(int i= 0;i<len;i+=2){
      String s = substring(i,i+2);
      int ss = int.parse(s , radix: 16);
      total += ss;
    }
    

    int c = total % 256;
    
    return  c.toRadixString(16).fixSize(2);

   }



  /// 固定长度，
  String fixSize(int size,{String prefiex = '0',bool fromH = true}){
    
    int cLength = length;

    if(cLength >= size){
      if(fromH){
        return substring(0,size);
      }else{
        return substring(cLength - size,cLength);
      }
    }else{
      if(fromH){ // 位数不够前面补0
        String ret = padLeft(size,prefiex);
        return ret;
      }else{
        return padRight(size,prefiex);
      }
    }
    
  }

  

  int get intValue{
    return int.parse(this);
  }


  String get deviceCode{
    List arr = split('-');
    if(arr.length == 2){
      return arr.last;
    }else{
      return this;
    }
  }


  String trim() {
    int len = length;
    int st = 0;
    while ((st < len) && (codeUnitAt(st) <= ' '.codeUnits[0])) {
      st++;
    }
    while ((st < len) && (codeUnitAt(len - 1) <= ' '.codeUnits[0])) {
      len--;
    }
    return ((st > 0) || (len < length)) ? substring(st, len) : this;
  }


  // 16进制转10进制
  String get convert16_10{
    var ret = int.tryParse(this, radix: 16);
    return "${ret}";
  }




  // 16进制转2进制
  String get convert16_2{
    var ret = int.tryParse(this, radix: 2);
    if(ret != null){
      return ret.toString();
    }else{
      BYLog.e('16进制转2进制失败${this}');
      return '';
    }
  }

  String get convert16_text{
    String ret = '';
    for(int i =0;i<length;i+=2){
      String hex = substring(i,i+2);
      int de = int.parse(hex,radix:16);
      ret += String.fromCharCode(de);
    }

    return ret;
  }



  // 10进制转16进制
  String get convert10_16{
    var ret = intValue.toRadixString(16);
    return ret ;
  }



  String get convert16_version{
    if(length != 4){
      BYLog.e('转换为型号错误${this}');
      return '0.0';
    }
    var ret = '';
    int num1 = substring(0,2).convert16_10.intValue;
    int num2 = substring(2,4).convert16_10.intValue;
    if(num1 >= 100){
      int numM = num1 - 100;
      ret = "1." + numM.toString() + "." + num2.toString();

    }else if(num1 >= 200){
      int numM = num1 - 200;
      ret = "2." + numM.toString() + "." + num2.toString();
    } 
    else{
      ret = num1.toString() + "." + num2.toString();
    }


    return ret;
  }





  // List<String> spliteCmd(List<int> arrCount){
  //   int total = arrCount.reduce((a, b) => a + b);
  //   if(length != total * 2){
  //     BYLog.e('命令分割失败${this}');
  //     return [];
  //   }else{
  //     List<String> ret = [];
  //     int start = 0;
  //     for(int i =0;i<arrCount.length;i++){
  //       int l = arrCount[i];
  //       String val = substring(start,start + l*2);
  //       ret.add(val);
  //       start = start + l*2;
  //     }

  //     return ret;

  //   }

  // }






  
}
