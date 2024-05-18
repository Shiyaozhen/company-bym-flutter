import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hex/hex.dart';
import 'package:wifi_iot/wifi_iot.dart';

class TcpPage extends StatefulWidget {
  const TcpPage({Key? key}) : super(key: key);

  @override
  _TcpPageState createState() => _TcpPageState();
}

class _TcpPageState extends State<TcpPage> {
  final TextEditingController ipAddressController =
      TextEditingController(text: '192.168.4.1');
  final TextEditingController portController =
      TextEditingController(text: '80');
  final TextEditingController messageController =
      TextEditingController(text: 'Hello Server');
  final TextEditingController wifiNameController =
      TextEditingController(text: 'AP_A0999661');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  Socket? socket;

  void connectToTcpServer() async {
    String ipAddress = ipAddressController.text;
    int port = int.tryParse(portController.text) ?? 0;

    try {
      socket = await Socket.connect(ipAddress, port);
      Fluttertoast.showToast(msg: '成功连接到服务器');
      // 监听服务器返回的数据
      socket!.listen(
        (List<int> data) {
          String message = String.fromCharCodes(data);
          print('收到消息：$message');
        },
        onError: (error) {
          print('接收数据时发生错误：$error');
        },
        onDone: () {
          print('连接已关闭');
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: '无法连接到服务器：$e');
    }
  }

  void connectToWifiAndTcpServer() async {
    String wifiName = wifiNameController.text;
    String password = passwordController.text;
    var connectionResult = await WiFiForIoTPlugin.connect(wifiName,
        password: password, security: NetworkSecurity.WPA);
    print(connectionResult);

    //   if (connectionResult) {
    //   await Future.delayed(Duration(seconds: 10));
    //   connectToTcpServer();
    // }
  }

  void sendMessage() {
    String hexString =
        "4040000421d63487c60c022242454e59220d0a227a6a62656e79303031227a2323"; // 十六进制字符串，无需空格
    List<int> bytes = HEX.decode(hexString); // 将十六进制字符串转换为字节列表
    if (socket != null) {
      socket!.add(bytes);
      Fluttertoast.showToast(msg: '发送消息：$hexString');
    } else {
      Fluttertoast.showToast(msg: '未连接到服务器');
    }
  }

  void sendHeart() {
    String hexString = "404000010d0102030401192323"; // 十六进制字符串，无需空格
    List<int> bytes = HEX.decode(hexString); // 将十六进制字符串转换为字节列表
    if (socket != null) {
      socket!.add(bytes);
      Fluttertoast.showToast(msg: '发送消息：$hexString');
    } else {
      Fluttertoast.showToast(msg: '未连接到服务器');
    }
  }

  //字节转换
  List<int> hexStringToByteArray(String hexString) {
    List<int> byteArray = [];
    for (int i = 0; i < hexString.length; i += 2) {
      String byte = hexString.substring(i, i + 2);
      byteArray.add(int.parse(byte, radix: 16));
    }
    return byteArray;
  }

  void disconnectFromTcpServer() async {
    if (socket != null) {
      await socket!.close();
      print('已断开连接');
      Fluttertoast.showToast(msg: '已断开连接');
    } else {
      print('未连接到服务器');
    }
  }

  @override
  void dispose() {
    if (socket != null) {
      socket!.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TCP Connection'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //连接wifi
            TextField(
              controller: wifiNameController,
              decoration: InputDecoration(
                labelText: 'WiFi Name',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: connectToWifiAndTcpServer,
              child: Text('Connect'),
            ),
            //连接TCP
            TextField(
              controller: ipAddressController,
              decoration: InputDecoration(
                labelText: 'IP Address',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: portController,
              decoration: InputDecoration(
                labelText: 'Port',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: connectToTcpServer,
              child: Text('Connect'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: sendMessage,
                  child: Text('ConfigNet'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: sendHeart,
                  child: Text('SendHeart'),
                ),
                SizedBox(width: 16.0),
              ],
            ),
            ElevatedButton(
              onPressed: disconnectFromTcpServer,
              child: Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}
