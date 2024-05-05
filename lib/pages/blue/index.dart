import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  late FlutterBlue flutterBlue;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;

  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBlue.instance;
    _startScan();
  }

  void _startScan() {
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty && !devices.contains(r.device)) {
          setState(() {
            devices.add(r.device);
          });
        }
      }
    });

    flutterBlue.startScan();
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();
      services.forEach((service) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.properties.write) {
            setState(() {
              this.characteristic = characteristic;
              connectedDevice = device;
            });
          }
        });
      });
    } catch (e) {
      print('无法连接到设备: $e');
    }
  }

  void _sendData(String data) async {
    if (characteristic != null && connectedDevice != null) {
      List<int> bytes = data.codeUnits;
      await characteristic!.write(bytes);
    }
  }

  void _receiveData() async {
    if (characteristic != null && connectedDevice != null) {
      List<int> value = await characteristic!.read();
      // 处理接收到的数据
      String receivedData = String.fromCharCodes(value);
      print('接收到的数据: $receivedData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('蓝牙页面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('附近的蓝牙设备：'),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  print(devices); // 打印消息
                  return ListTile(
                    title: Text(devices[index].name ?? 'unknown'),
                    onTap: () {
                      _connectToDevice(devices[index]);
                    },
                  );
                },
              ),
            ),
            if (connectedDevice != null) Text('已连接到：${connectedDevice!.name}'),
            ElevatedButton(
              onPressed: () {
                _sendData('Hello, Bluetooth!'); // 发送数据
              },
              child: const Text('发送数据'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _receiveData(); // 接收数据
            //   },
            //   child: const Text('接收数据'),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }
}
