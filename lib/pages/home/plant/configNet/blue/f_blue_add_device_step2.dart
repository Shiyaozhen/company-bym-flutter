import 'package:BYM/components/ByDialog.dart';
import 'package:BYM/utils/BLEManager.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class PowerStation {
  String name;
  String timezone;

  PowerStation({required this.name, required this.timezone});
}

class FBlueAddDeviceStep2 extends StatefulWidget {
  const FBlueAddDeviceStep2({super.key});

  @override
  State<FBlueAddDeviceStep2> createState() => _FBlueAddDeviceStep2State();
}

class _FBlueAddDeviceStep2State extends State<FBlueAddDeviceStep2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F7FF),
          title: Text(
            '扫码添加设备',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
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
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xFFF5F7FF)),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 13.0, right: 13.0),
              child: Column(
                children: [FBlueStep()],
              ),
            ),
          ],
        ));
  }
}

class FBlueStep extends StatefulWidget {
  const FBlueStep({super.key});

  @override
  State<FBlueStep> createState() => _FBlueStepState();
}

class _FBlueStepState extends State<FBlueStep> {
  @override
  
    bool is_Connected =  false;
  void selectPlant(List<PowerStation> plantList) {
    int selectIndex = 0;
    print(plantList.length);
    if (plantList.length == 0) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => StatefulBuilder(
                builder: (context, setState) {
                  return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 350,
                        maxHeight: MediaQuery.of(context).size.height * 0.65,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 23.0, left: 16.0, right: 16.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '选择电站',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.65 -
                                            MediaQuery.of(context).size.height *
                                                0.52,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/ic_plant_add.svg'),
                                          SizedBox(
                                            height: 21.0,
                                          ),
                                          Text(
                                            '暂无电站，请添加',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                    color: Color(0xFF878787)),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.65 -
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.48,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                      ),
                                                      child: const Text(
                                                        '创建电站',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF5475F7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Color(
                                                                    0xFF5475F7)),
                                                      ),
                                                      child: const Text(
                                                        '确定',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ));
                },
              ));
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            ScrollController scrollController = ScrollController();
            return Container(
              width: 350,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 19,
                  ),
                  Text(
                    '选择电站',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: plantList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex = index;
                            });
                          },
                          child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  selectIndex == index
                                                      ? Icons.check_circle
                                                      : Icons
                                                          .radio_button_unchecked,
                                                  color: selectIndex == index
                                                      ? Color(0xFF5475F7)
                                                      : Color(0xFF383838),
                                                  size: 24.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        plantList[index].name),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(plantList[index]
                                                        .timezone),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              size: 20,
                                            ),
                                            color: const Color(0xFF383838),
                                            onPressed: () {
                                              BYRoute.toNamed('/ChangeInfo');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 320,
                                    height: 1,
                                    color: Color(0xFFD4DBED),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  BYRoute.toNamed('/FAddPlant');
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: const Text(
                                  '创建电站',
                                  style: TextStyle(
                                    color: Color(0xFF5475F7),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF5475F7)),
                                ),
                                child: const Text(
                                  '确定',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            );
          },
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    String mi = '4000000';
    var step = 1;
    final screenHeight = MediaQuery.of(context).size.height;
    bool valueFromChild = false;
    void updateValue(bool value) {
      setState(() {
        valueFromChild = value;
      });
      print(valueFromChild);
    }

    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(color: Color(0xFF939393)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Color(0xFF939393)),
                      ),
                    ),
                  ),
                  Text('基本信息',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Color(0xFF939393)))
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: 50,
              height: 1,
              child: CustomPaint(
                painter: DashedLinePainter(),
              ),
            )),
            Container(
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFF5475F7),
                      border: Border.all(color: Color(0xFF5475F7)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '2',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  Text('设备配网',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Color(0xFF5475F7)))
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: 50,
              height: 1,
              child: CustomPaint(
                painter: DashedLinePainter(),
              ),
            )),
            Container(
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: (step == 2 || step == 3)
                          ? Border.all(color: Color(0xFF5475F7))
                          : Border.all(color: Color(0xFF939393)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: (step == 2 || step == 3)
                                    ? Color(0xFF5475F7)
                                    : Color(0xFF939393)),
                      ),
                    ),
                  ),
                  Text('绑定微逆',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: (step == 2 || step == 3)
                              ? Color(0xFF5475F7)
                              : Color(0xFF939393)))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.0,
        ),
        Column(
          children: [
            Visibility(
                visible: !is_Connected,
                child: Column(
                  children: [
                    TopTipState(callback: updateValue),
                    SizedBox(
                      height: 25.0,
                    ),
                    Column(
                      children: [
                        Visibility(
                            visible: _isChecked_one,
                            child: Column(
                              children: [
                                WiFiNet(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                PWDNet(),
                                SizedBox(
                                  height: 8.0,
                                ),
                                FailReasonState(),
                              ],
                            )),
                        Visibility(visible: _isChecked_two, child: InterNet())
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: screenHeight - 700),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: const Text(
                                  '上一步',
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
                                   setState(() {
                                    print('object');
                                     is_Connected = !is_Connected;
                                     print(is_Connected);
                                     if(_isChecked_one){
                                        BLEManager().startHeart(duration:const Duration(seconds:6),heartComment: BLEManager().getNetConfigCmd(1, "BENY", "zjbeny001", false, "", "", "",));
                                     }
                                   });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF5475F7)),
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
                    )
                  ],
                )),
            Visibility(
                visible: is_Connected,
                child: Column(
                  children: [
                    ConnectingStatefulWidget(),
                  ],
                ))
          ],
        )
      ],
    ));
  }
}

//虚线组件
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF939393)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final dashWidth = 2;
    final dashSpace = 2;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => false;
}

//顶部提示内容

class TopTipState extends StatefulWidget {
  final Function(bool) callback;

  TopTipState({required this.callback});

  @override
  State<TopTipState> createState() => _TopTipState();
}

bool _isChecked_one = true;
bool _isChecked_two = false;

class _TopTipState extends State<TopTipState> {
  Widget build(BuildContext context) {
    String childValue = '';
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 100,
          padding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, left: 19.0, right: 19.0),
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(6.0)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '选择设备联网方式',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isChecked_one == true
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          size: 28,
                        ),
                        color: _isChecked_one
                            ? const Color(0xFF5475F7)
                            : Color(0xFFCAD2E5),
                        onPressed: () {
                          setState(() {
                            _isChecked_one = true;
                            _isChecked_two = false;
                            widget.callback(_isChecked_two);
                          });
                        },
                      ),
                      Text(
                        'Wi-Fi',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Color(0xFF939393)),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 50.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _isChecked_two
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 28,
                          ),
                          color: _isChecked_two
                              ? const Color(0xFF5475F7)
                              : Color(0xFFCAD2E5),
                          onPressed: () {
                            setState(() {
                              _isChecked_two = true;
                              _isChecked_one = false;
                              widget.callback(_isChecked_two);
                            });
                          },
                        ),
                        Text(
                          '以太网',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Color(0xFF939393)),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
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
            child: Text('Wi-Fi (此设备只支持使用2.4Hz Wi-Fi连接使用)',
                style: Theme.of(context).textTheme.displayLarge),
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
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
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

//以太网静态IP
class InterNet extends StatefulWidget {
  const InterNet({Key? key}) : super(key: key);

  @override
  State<InterNet> createState() => _InterNetState();
}

class _InterNetState extends State<InterNet> {
  bool switchValue = false; // 将 switchValue 定义为 _InterNetState 的成员变量

  @override
  Widget build(BuildContext context) {
    String ip_address1 = '';
    String ip_address2 = '';
    String ip_address3 = '';
    String ip_address4 = '';
    String mask1 = '';
    String mask2 = '';
    String mask3 = '';
    String mask4 = '';
    String default_gateway1 = '';
    String default_gateway2 = '';
    String default_gateway3 = '';
    String default_gateway4 = '';
    return Container(
      height:switchValue ? 335.0 : 70,
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '静态IP',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Switch(
                value: switchValue,
                activeColor: Color(0xFF5475F7),
                onChanged: (value) {
                  BYLog.d('wifi名密码💓💓💓💓💓💓💓💓💓💓💓💓💓💓💓${value}');
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
            ],
          ),
          Visibility(
            visible: switchValue,
            child: Column(children: [
             SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Ip Address',
              style: TextStyle(color: Color(0xFF939393), fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFCAD2E5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        ip_address1 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        ip_address2 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        ip_address3 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        ip_address4 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Mask',
              style: TextStyle(color: Color(0xFF939393), fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFCAD2E5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        mask1 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        mask2 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        mask3 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        mask4 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
                  SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Default gateway',
              style: TextStyle(color: Color(0xFF939393), fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFCAD2E5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        default_gateway1 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        default_gateway2 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        default_gateway3 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    '.',
                    style: TextStyle(fontSize: 30, color: Color(0xFFCAD2E5)),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        default_gateway4 = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 0, max: 255),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          )
          ],))
        ],
      ),
    );
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int value = int.tryParse(newValue.text) ?? 0;

    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }

    return newValue;
  }
}
