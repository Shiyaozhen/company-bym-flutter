import 'dart:async';
import 'package:BYM/get_pages.dart';
import 'package:BYM/utils/ERApp.dart';
import 'package:BYM/utils/BYDBHealper.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:BYM/utils/Device.dart';
import 'package:BYM/utils/ERChargerData.dart';
import 'package:BYM/utils/by_cmd_util.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';

import 'package:get/get_connect/http/src/utils/utils.dart';

enum ConnectType { ble, udp, tcp, none }

enum ERError {
  unknown,
  none,
  timeout,
}

typedef CompleteCallback = void Function(bool, ERError, String);

class BLEManager {
  BLEManager._internal();

  factory BLEManager() => _instance;

  static final BLEManager _instance = BLEManager._internal();

  // MARK:  -
  ConnectType currentConnectType = ConnectType.none; // 是否连接上的标志位
  Device?
      connectingDevice; // 我们的SDK是必须有这个属性的，有这个属性才能记录连接的设备，在正式连上之后才会同步getx上的数据，中断时也会同步
  StackSendBlock stackSend = StackSendBlock();

  String? heartCmd; // 当前发送的心跳
  int heartTimeOutCount = 0;
  Timer? headT;
  Timer? headTimeoutT;

  ScanResult? scanResult;
  BluetoothCharacteristic? rCharac; // 读数据特征
  BluetoothCharacteristic? wCharac; // 写数据特征
  StreamSubscription? _devieRecSubscription;

  void setup() {
    // 初始化数据
    initP();
  }

  // 初始化数据
  void initP() {
    // 初始化蓝牙相关
    initBLE();
    initSDKP();
    initSDKGetData();
  }

  // 初始化蓝牙相关
  void initBLE() {
    _devieRecSubscription?.cancel();
    _devieRecSubscription = null;
    rCharac = null;
    wCharac = null;
    scanResult = null;
  }

  // 初始化
  void initSDKP() {
    currentConnectType = ConnectType.none; // 是否连接上的标志位
    connectingDevice = null; //
    heartTimeOutCount = 0; // 心跳超时恢复
    stackSend = StackSendBlock();
    heartCmd = null;
    stopHeart();
  }

  void initSDKGetData() {
    ERApp().updateConnectingDevice(Device());
  }

// MARK:  -  心跳 ♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️
  void startHeart(
      {Duration duration = const Duration(seconds: 2), String? heartComment}) {
    stopHeart();
    heartCmd = heartComment;
    headT = Timer.periodic(duration, (Timer timer) {
      heartBeat();
    });
  }

  void stopHeart() {
    headT?.cancel();
    headT = null;

    headTimeoutT?.cancel();
    headTimeoutT = null;
  }

  void heartBeat() {
    if (currentConnectType == ConnectType.none) {
      BYLog.e('当前没有连接');
    } else {
      heartHandler();
    }
  }

  void heartHandler() async {
    // if(heartTimeOutCount >= 100){ // 心跳超时
    //   BYLog.d('心跳超时');
    //   disConnect();

    // }else{
    if (stackSend.isEmpty()) {
      // 当前命令栈为空，发送心跳

      String cmd = heartCmd ?? defaultHeartCmd();
      BYLog.d('微逆发送心跳💓💓💓💓💓💓💓💓💓💓💓💓💓💓💓${cmd}');
      await sendCMD(cmd, currentConnectType == ConnectType.ble);
      headTimeoutT = Timer(Duration(seconds: 3), () {
        heartTimeOutCount++;
      });
    } else {
      BYLog.d('当前有命令在发送中');
    }

    // }
  }

  // MARK: - 断开连接
  Future disConnect() async {
    await scanResult?.device.disconnect();
    initP();
  }

  // MARK: - 连接设备 ###############################################################
  Future<bool> connectDevice(Device device) async {
    connectingDevice = device;
    if (device.isBLEConnect) {
      // 这里可以等待连接成功，设置连接方式，
      await bleConnectDevice(device);
      if (currentConnectType == ConnectType.ble) {
        ERApp().updateConnectingDevice(connectingDevice!);
        return true;
      } else {
        await disConnect();
        return false;
      }
    } else {
      return false;
    }
  }

  // 蓝牙连接
  Future bleConnectDevice(Device device) async {
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    // 这里好像有个隐患，要确保只在蓝牙扫描列表跳过扫描
    if (device.bleScanRet != null) {
      FlutterBluePlus.stopScan();
      scanResult = device.bleScanRet;
    } else {
      // 扫描15秒 失败的处理
      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
        withNames: [device.account!],
      );

      // 扫描成功的返回
      FlutterBluePlus.scanResults.listen((results) {
        if (connectingDevice == null) {
          return;
        }
        if (results.isNotEmpty) {
          ScanResult ret = results.first;
          if (ret.device.advName == connectingDevice!.account) {
            FlutterBluePlus.stopScan();
            scanResult = ret;
          }
        }
      });
    }

    // 要么超时停止扫描，要么扫描到设备停止扫描
    await FlutterBluePlus.isScanning
        .where((event) => () {
              return !FlutterBluePlus.isScanningNow;
            }())
        .first;

    if (scanResult != null) {
      BYLog.d('扫描到设备');
      // 开始连接设备
      await bleConDevice(scanResult!.device);
    } else {
      BYLog.d('扫描超时');
      return;
    }
  }

  // 连接蓝牙设备
  Future bleConDevice(BluetoothDevice device) async {
    // 连接设备
    await device.connect();

    // TOOD，这里要等待连接上，连接不上怎么办
    await device.connectionState
        .where((event) => event == BluetoothConnectionState.connected)
        .first;

    await bleGetChar(device);
  }

  // 连接成功后获取收发数据特征
  Future bleGetChar(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    //  这里假定了连接的设备一定是我们的设备，所以没做数组数量判断
    BluetoothService? service;
    for (BluetoothService ser in services) {
      if (ser.uuid.str == "a002") {
        service = ser;
      }
    }

    if (service == null) {
      return;
    }
    var characteristics = service.characteristics;
    wCharac = characteristics[4]; // 发送数据
    // 接收蓝牙消息
    rCharac = characteristics[5];

    _devieRecSubscription = rCharac!.onValueReceived.listen((value) {
      String cmd = _byte2String(value);
      receiveHandle(cmd);
    });
    await rCharac!.setNotifyValue(true);
    currentConnectType = ConnectType.ble;
  }

  // 发送数据 ################################################
  Future sendCmdAndStartTimet(String cmd, CompleteCallback complete,
      [int currentCount = 0,
      Duration duration = const Duration(seconds: 3),
      int failMaxCount = 5]) async {
    if (currentCount >= failMaxCount) {
      // 删除命令栈中的操作
      stackSend.removeCmd(cmd);
      BYLog.e('发送${failMaxCount}次失败，断连');
      complete(false, ERError.timeout, '');
    } else {
      Timer t = Timer(duration, () {
        // 失败了不会直接返回失败，而是再发送，直到最大发送失败处
        sendCmdAndStartTimet(cmd, complete, currentCount + 1);
      });

      stackSend.add(SendBlock(complete, cmd, t));

      await sendCMD(cmd, currentConnectType == ConnectType.ble);
    }
  }

  Future sendCMD(String cmd, bool isBLE) async {
    if (isBLE) {
      await writeContent(cmd);
    }
  }

  // 蓝牙发送数据
  Future writeContent(String content) async {
    try {
      BYLog.d('蓝牙正在发送命令：${content}');
      await wCharac!.write(_getRandomBytes(content));
    } catch (e) {}
  }

  // 接收数据 ################################################
  void receiveHandle(String cmd) {
    BYLog.d('📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲接收到命令content:${cmd}');
    // TODO:  针对命令校验不合格的地方需要先缓存连接
    if (cmd.length < 14) {
      BYLog.e('接收到的数据不符合规范${cmd}');
      return;
    }
    int msgid = BYCmdUtil.getRecMsgType(cmd);
    String content = cmd.substring(12, cmd.length - 2);
    BYLog.d(
        '📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲📲接收到命令id:${msgid}content:${cmd}');

    if (!stackSend.has(cmd)) {
      // 心跳命令没有回调，所以分开
      if (isHeartCmd(cmd)) {
        BYLog.d('接收到心跳${cmd}');
        headTimeoutT?.cancel();
        heartTimeOutCount = 0;

        connectingDevice!.chargeGetData.currentHeartData = cmd;

        ERApp().updateConnectingDevice(connectingDevice!);

        if (connectingDevice!.isCharger) {
          handleCPHeartData(cmd);
        } else {
          handleMIHeartData(cmd);
        }
      } else {
        BYLog.d('收到的不是发送的命令的回应：${cmd}');
      }
    } else {
      SendBlock? item = stackSend.getFromCmd(cmd);
      if (item != null) {
        stackSend.remove(item);
      }
      item?.timer?.cancel();

      if (msgid == 4) {
        // 处理通用命令回调
        BYLog.d('获取设备型号${cmd}');
        DeviceTypeData data = DeviceTypeData(content);
        connectingDevice!.chargeGetData.deviceTypeData = data;
        ERApp().updateConnectingDevice(connectingDevice!);

        if (connectingDevice!.deviceType !=
            connectingDevice!.chargeGetData.deviceTypeData!.devciceTypeCode) {
          BYLog.d('当前型号不准确');
          DeviceTypeData deviceTypeData =
              connectingDevice!.chargeGetData.deviceTypeData!;

          connectingDevice!.deviceType = deviceTypeData.devciceTypeCode!;
          connectingDevice!.pileversion = deviceTypeData.pileVersion!;
          connectingDevice!.software = deviceTypeData.softWare!;
          connectingDevice!.hardware = deviceTypeData.hardWare!;
        }

        item?.block!(true, ERError.none, cmd);
      } else {
        if (connectingDevice!.isCharger) {
          if (msgid == 107) {
            BYLog.d('设置DLB模式回调${cmd}');
            bool isSuc = content.convert16_10.intValue == 1;
            item?.block!(isSuc, ERError.none, cmd);
          } else if (msgid == 108) {
            BYLog.d('设置接地检测回调${cmd}');
            bool isSuc = content.convert16_10.intValue == 1;
            item?.block!(isSuc, ERError.none, cmd);
          } else {
            BYCmdUtil.handleCPCmd(cmd);
            item?.block!(true, ERError.none, cmd);
          }
        } else {
          BYLog.d('设置DLB模式回调${cmd}');
          item?.block!(true, ERError.none, cmd);
        }
      }
    }
  }

  // 处理充电桩的心跳
  void handleCPHeartData(String cmd) {
    int msgid = BYCmdUtil.getRecMsgType(cmd);
    String content = cmd.substring(12, cmd.length - 2);
    if (msgid == 112) {
      // 获取实时数据
      BYLog.d('获取实时数据');
      CPRealTimeData data = CPRealTimeData(content, connectingDevice!.isSingle);
      connectingDevice!.chargeGetData.realTimeData = data;
      ERApp().updateConnectingDevice(connectingDevice!);
    }
  }

  void handleMIHeartData(String cmd) {
    int msgid = BYCmdUtil.getRecMsgType(cmd);
    String content = cmd.substring(12, cmd.length - 2);
    if (msgid == 23) {
      // 获取实时数据
      BYLog.d('微逆配网回应' + content);
      if (content == '03') {
        disConnect();
        BYRoute.toNamed('/FBlueAddDeviceStep3');
      }
    } else {
      BYLog.d('微逆其他回应' + content);
    }
  }

  // 处理充电桩set命令，这种命令的回调只有成功还是失败，并没有其他信息
  void handleCPSetData(String cmd) {}

  List<int> _getRandomBytes(String content) {
    // 将字符串转换为字节数组
    List<int> bytes = utf8.encode(content);
    return bytes;
  }

  String _byte2String(List<int> bytes) {
    String content = String.fromCharCodes(bytes);
    return content;
  }

  bool isSameCMD(String cmd1, String cmd2) {
    if (cmd1.length <= 8 || cmd2.length <= 8) {
      return false;
    } else {
      String scmd1 = cmd1.substring(0, 8);
      String scmd2 = cmd1.substring(0, 8);

      return scmd1 == scmd2;
    }
  }

  bool isHeartCmd(String cmd) {
    if (cmd.length < 5) {
      return false;
    } else {
      return cmd.substring(4, 5) == '1';
    }
  }

  String defaultHeartCmd() {
    String heartCmd = BYCmdUtil.makeSendCMD(112, 123456, '', isHeartCmd: true);
    if (connectingDevice!.isMI) {
    } else if (connectingDevice!.isER) {}
    return heartCmd;
  }

  // 获取设备型号
  Future getDeviceType(CompleteCallback complete) async {
    String cmd = BYCmdUtil.makeSendCMD(4, connectingDevice!.pass!.intValue, '',
        isHeartCmd: false);
    await sendCmdAndStartTimet(cmd, complete);
  }

  // 获取控制使能
  Future getControlEnable(CompleteCallback complete) async {
    String cmd = BYCmdUtil.makeSendCMD(
        113, connectingDevice!.pass!.intValue, '',
        isHeartCmd: false);
    await sendCmdAndStartTimet(cmd, complete);
  }

  // 设置DLB配置
  Future setDLBMode(
      bool isDLBEnable,
      bool isExtremMode,
      String pvMaxCurrent,
      bool? autoModeEnable,
      String? autoModeStartH,
      String? autoModeEndH,
      CompleteCallback complete) async {
    String dlbEnableS = isDLBEnable ? "01" : "00";
    String extremeModeS = isExtremMode ? "01" : "00";
    String pvMaxCurrentS = pvMaxCurrent.convert10_16;
    String autoModeEnableS = "";
    if (autoModeEnable != null) {
      autoModeEnableS = autoModeEnable ? "01" : "00";
    }
    String startH = "";
    if (autoModeStartH != null) {
      startH = autoModeStartH.convert10_16.fixSize(2);
    }

    String endH = "";
    if (autoModeEndH != null) {
      endH = autoModeEndH.convert10_16.fixSize(2);
    }

    String content = dlbEnableS +
        extremeModeS +
        pvMaxCurrentS +
        autoModeEnableS +
        startH +
        endH;

    String cmd = BYCmdUtil.makeSendCMD(
        107, connectingDevice!.pass!.intValue, content,
        isHeartCmd: false);
    await sendCmdAndStartTimet(cmd, complete);
  }

  Future netConfig(
      int modeType,
      String wifiSSID,
      String wifiPass,
      bool isStaticIP,
      String staticIP,
      String getway,
      String subnetMask,
      CompleteCallback complete) async {
    var cmdContent = modeType.toString().convert10_16.fixSize(2);

    if (modeType == 1) {
      cmdContent =
          cmdContent + wifiSSID.converttext_16.fixSize(60, fromH: false);

      cmdContent =
          cmdContent + wifiPass.converttext_16.fixSize(60, fromH: false);
      cmdContent = cmdContent + "00";
    } else {}

    String cmd = BYCmdUtil.makeSendCMD(
        23, connectingDevice!.pass!.intValue, cmdContent,
        isHeartCmd: false);

    BYLog.d("微逆发送配网指令" + cmd);
    await BLEManager().sendCmdAndStartTimet(cmd, complete);
  }

  getNetConfigCmd(int modeType, String wifiSSID, String wifiPass,
      bool isStaticIP, String staticIP, String getway, String subnetMask) {
    var cmdContent = modeType.toString().convert10_16.fixSize(2);

    if (modeType == 1) {
      cmdContent =
          cmdContent + wifiSSID.converttext_16.fixSize(60, fromH: false);

      cmdContent =
          cmdContent + wifiPass.converttext_16.fixSize(60, fromH: false);
      cmdContent = cmdContent + "00";
    } else {}

    String cmd = BYCmdUtil.makeSendCMD(
        23, connectingDevice!.pass!.intValue, cmdContent,
        isHeartCmd: true);

    return cmd;
  }
}

class SendBlock {
  CompleteCallback? block;
  String? sendCmd;
  Timer? timer;

  SendBlock(this.block, this.sendCmd, this.timer);
}

class StackSendBlock {
  List<SendBlock> _arrSendFutures = [];

  StackSendBlock() {
    empty();
  }

  SendBlock? getFromCmd(String cmd) {
    for (SendBlock item in _arrSendFutures) {
      if (_isSameCMD(cmd, item.sendCmd!)) {
        return item;
      }
    }

    return null;
  }

  int getIndex(String cmd) {
    for (int i = 0; i < _arrSendFutures.length; i++) {
      SendBlock item = _arrSendFutures[i];
      if (_isSameCMD(cmd, item.sendCmd!)) {
        return i;
      }
    }
    return -1;
  }

  bool isEmpty() {
    return _arrSendFutures.isEmpty;
  }

  bool has(String cmd) {
    for (SendBlock item in _arrSendFutures) {
      if (_isSameCMD(cmd, item.sendCmd!)) {
        return true;
      }
    }

    return false;
  }

  bool _isSameCMD(String cmd1, String cmd2) {
    if (cmd1.length <= 8 || cmd2.length <= 8) {
      return false;
    } else {
      String scmd1 = cmd1.substring(0, 8);
      String scmd2 = cmd1.substring(0, 8);

      return scmd1 == scmd2;
    }
  }

  void remove(SendBlock item) {
    int index = getIndex(item.sendCmd!);
    if (index != -1) {
      removeAt(index);
    }
  }

  void removeCmd(String cmd) {
    int index = getIndex(cmd);
    if (index != -1) {
      removeAt(index);
    }
  }

  void add(SendBlock item) {
    if (has(item.sendCmd!)) {
      BYLog.d(this);
      return;
    }
    _arrSendFutures.add(item);
    BYLog.d(this);
  }

  void removeAt(int index) {
    _arrSendFutures.removeAt(index);
    BYLog.d(this);
  }

  void empty() {
    for (SendBlock item in _arrSendFutures) {
      item.timer?.cancel();
    }
    _arrSendFutures = [];
    BYLog.d(this);
  }

  @override
  String toString() {
    String ret = 'arrStack:[';
    for (SendBlock item in _arrSendFutures) {
      ret = ret + '${item.sendCmd!}';
    }
    ret = ret + ']';
    return ret;
  }
}
