import 'package:BYM/components/ByDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Byhand extends StatefulWidget {
  const Byhand({super.key});

  @override
  State<Byhand> createState() => _ByhandState();
}

class _ByhandState extends State<Byhand> {
  @override
  TextEditingController _controllerDevice = TextEditingController();
  bool _showClearDeviceutton = false;
  void _clearDeviceTextField() {
    setState(() {
      _controllerDevice.clear();
      _showClearDeviceutton = false;
    });
  }

  void initState() {
    super.initState();
    _controllerDevice.addListener(() {
      setState(() {
        _showClearDeviceutton = _controllerDevice.text.isNotEmpty;
      });
    });
  }

  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String type = arguments['type'];
    void sure() {
      print(_controllerDevice.text.substring(0, 1));
      if (type == '1') {
        // print('添加成功');
        if (_controllerDevice.text.substring(0, 1) == '9' &&
            _controllerDevice.text.length == 8) {

        } else if ((_controllerDevice.text.substring(0, 1) == 'A' ||
                _controllerDevice.text.substring(0, 1) == 'C') &&
            _controllerDevice.text.length == 8) {
              
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ByDialog(
                titleText: '温馨提示',
                contentText: '设备序列号有误',
                cancelText: '',
                confirmText: '确认',
                onCancelPressed: () {
                  Navigator.of(context).pop();
                },
                onConfirmPressed: () {
                  print("执行退出登录的操作");
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '手动输入',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF383838),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 21.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '请输入设备序列号',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '例如:EMU编号：90000051；MI-W编号：C0000025',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Color(0xFF7989B2)),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              maxLength: 8,
              textAlign: TextAlign.center,
              controller: _controllerDevice,
              decoration: InputDecoration(
                hintText: '请输入设备序列号',
                suffixIcon: _showClearDeviceutton
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Color(0xFF7989B2)),
                        onPressed: _clearDeviceTextField,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ElevatedButton(
              onPressed: () {
                sure();
              },
              child: Text('确定',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
