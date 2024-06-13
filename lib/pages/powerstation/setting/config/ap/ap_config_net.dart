import 'package:BYM/generated/intl/messages_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ApConfigNet extends StatefulWidget {
  const ApConfigNet({super.key});

  @override
  State<ApConfigNet> createState() => _ApConfigNetState();
}

class _ApConfigNetState extends State<ApConfigNet> {
  int step = 0;

  void _handleNextButtonClick() {
    setState(() {
      step = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> arguments = Get.arguments;
    // final String MIId = arguments['MIId'];
    // print(MIId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F7FF),
        title: Text(
          '设备配网',
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
      body: Container(
          color: Color(0xFFF5F7FF),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25.0, left: 13.0, right: 13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //第一步
                    Visibility(
                      visible: step == 0,
                      child: Column(
                        children: [
                          TopTiptState(),
                          SizedBox(
                            height: 30.0,
                          ),
                          WiFiNet(),
                          SizedBox(
                            height: 20.0,
                          ),
                          PWDNet(),
                          SizedBox(
                            height: 2.0,
                          ),
                          FailReasonState(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 13.0, right: 13.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                            visible: step == 2,
                            child: ConnectingStatefulWidget()),
                      ])),
              Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 13.0, right: 13.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                            visible: step == 1,
                            child: ConfigSuccessStatefulWidget()),
                        SizedBox(
                          height: 50.0,
                        ),
                      ])),
            ],
          )),
      bottomSheet: Visibility(
        visible: step == 0,
        child: Container(
          height: 60.0,
          color: Color(0xFFF5F7FF),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text(
                    '返回',
                    style: TextStyle(
                      color: Color(0xFF5475F7),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  onPressed: _handleNextButtonClick,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF5475F7)),
                  ),
                  child: const Text(
                    '下一步',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: step == 1,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF5475F7)),
          ),
          child: const Text(
            '完成',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//顶部提示内容
class TopTiptState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '请为设备选择可用Wi-Fi',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('此设备只支持使用2.4Hz Wi-Fi连接使用',
              style: Theme.of(context).textTheme.displayMedium),
        )
      ],
    ));
  }
}

//Wi-Fi
class WiFiNet extends StatefulWidget {
  const WiFiNet({super.key});

  @override
  State<WiFiNet> createState() => _WiFiNetState();
}

class _WiFiNetState extends State<WiFiNet> {
  final TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;
  bool isObscure = true;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  void _clearTextField() {
    setState(() {
      _controller.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
            child:
                Text('Wi-Fi', style: Theme.of(context).textTheme.displayLarge),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '请输入您的WiFi名',
                  suffixIcon: _showClearButton
                      ? IconButton(
                          icon:
                              const Icon(Icons.clear, color: Color(0xFF7989B2)),
                          onPressed: _clearTextField,
                        )
                      : null,
                ),
              ),
            )),
      ],
    );
  }
}

//密码
class PWDNet extends StatefulWidget {
  const PWDNet({super.key});

  @override
  State<PWDNet> createState() => _PWDNetState();
}

class _PWDNetState extends State<PWDNet> {
  final TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;
  bool isObscure = true;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  void _clearTextField() {
    setState(() {
      _controller.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('密码', style: Theme.of(context).textTheme.displayLarge),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                obscureText: isObscure,
                controller: _controller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '请输入您的WiFi名',
                  suffixIcon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF7989B2)),
                ),
              ),
            )),
      ],
    );
  }
}

//失败原因
class FailReasonState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 20.0),
      child: Center(
        child: Text('Wi-Fi密码输入错误是最常见的失败原因之一，请仔细检查Wi-Fi密码'),
      ),
    );
  }
}

//底部按钮
// class BottomButtonStatefulWidget extends StatefulWidget {
//   @override
//   _BottomButtonStatefulWidgetState createState() =>
//       _BottomButtonStatefulWidgetState();

// }

class BottomButtonStatefulWidget extends StatelessWidget {
  bool isButtonEnabled = true;
  final VoidCallback onNextButtonClick;

  BottomButtonStatefulWidget({required this.onNextButtonClick}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.pop(context);
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(
                  '返回',
                  style: TextStyle(
                    color: Color(0xFF5475F7),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  onNextButtonClick();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF5475F7)),
                ),
                child: const Text(
                  '下一步',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//设备联网中
class ConnectingStatefulWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '设备联网',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('设备联网成功前,请勿离开此页面!',
              style: Theme.of(context).textTheme.displayMedium),
        ),
        SizedBox(
          height: 150.0,
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/ic_mi_nine.png',
                width: 100,
                height: 100,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Image.asset(
                'assets/ic_connect.png',
                width: 100,
                height: 100,
              )
            ],
          ),
        )
      ],
    ));
  }
}

//设备配网成功
class ConfigSuccessStatefulWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '设备联网成功!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 150.0,
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 10.0),
          child: Stack(
            // 使用Stack叠放图片
            children: [
              Image.asset(
                'assets/ic_mi_nine.png',
                width: 150,
                height: 150,
              ),
              Positioned(
                right: 0,
                bottom: 10,
                child: SvgPicture.asset(
                  'assets/ic_success.svg',
                  width: 25,
                  height: 25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
