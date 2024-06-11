import 'package:BYM/components/ByDialog.dart';
import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PowerStation {
  String name;
  String timezone;

  PowerStation({required this.name, required this.timezone});
}

class FBlueAddDeviceStep1 extends StatefulWidget {
  const FBlueAddDeviceStep1({super.key});

  @override
  State<FBlueAddDeviceStep1> createState() => _FBlueAddDeviceStep1State();
}

class _FBlueAddDeviceStep1State extends State<FBlueAddDeviceStep1> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    List<PowerStation> plantList = [
      PowerStation(name: '电站1', timezone: '时区1'),
      PowerStation(name: '电站2', timezone: '时区2'),
      PowerStation(name: '电站3', timezone: '时区3'),
    ];

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
                      color: Color(0xFF5475F7),
                      border: Border.all(color: Color(0xFF5475F7)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  Text('基本信息',
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
                      border:  Border.all(color: Color(0xFF939393)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '2',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color:Color(0xFF939393)),
                      ),
                    ),
                  ),
                  Text('设备配网',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Color(0xFF939393)))
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
                      border:  Border.all(color: Color(0xFF939393)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color:Color(0xFF939393)),
                      ),
                    ),
                  ),
                  Text('绑定微逆',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Color(0xFF939393)))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 34.0,
        ),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Baseline(
                baseline: 16, // 调整基线的位置，根据实际情况进行调整
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  '设备编号',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Baseline(
                baseline: 20, // 调整基线的位置，根据实际情况进行调整
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  '90000051',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              '请确认设备已通电；请尽量靠近设备.',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Color(0xFF939393)),
            ),
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        //空电站情况
        Visibility(
          visible: plantList.length == 0,
          child: Container(
            height: 280.0,
            padding: EdgeInsets.only(
                top: 23.0, bottom: 23.0, left: 14.0, right: 14.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('电站信息',
                        style: Theme.of(context).textTheme.headlineSmall),
                    InkWell(
                      onTap: () {
                        selectPlant(plantList);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 9.0, right: 9.0, top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF5475F7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        child: Text(
                          '快速建站',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF5475F7)),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 80.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '还没有电站,请点击',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF939393)),
                        ),
                        Text(
                          '“快速建站”',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF5475F7)),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        Visibility(
            visible: plantList.length > 0,
            child: Container(
                height: 280.0,
                padding: EdgeInsets.only(
                    top: 23.0, bottom: 23.0, left: 14.0, right: 14.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('电站信息',
                          style: Theme.of(context).textTheme.headlineSmall),
                      InkWell(
                        onTap: () {
                          selectPlant(plantList);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 9.0, right: 9.0, top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF5475F7),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          child: Text(
                            '选择电站',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: Color(0xFF5475F7)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '电站名称',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text('Plant-2024-05-06-02',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xFFF5F7FF)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '国家',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text('中国',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xFFF5F7FF)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '时区',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text('UTC+08:00',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(color: Color(0xFFF5F7FF)),
                  ),
                   SizedBox(
                    height: 20.0,
                  ), 
                ]))),
        Container(
          padding: EdgeInsets.only(top: screenHeight - 650),
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
                          MaterialStateProperty.all<Color>(Colors.white),
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
                      if (plantList.length == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ByDialog(
                              titleText: '温馨提示',
                              contentText: '您还没有创建电站,请先创建电站！',
                              cancelText: '',
                              confirmText: '返回',
                              onCancelPressed: () {
                                Navigator.of(context).pop();
                              },
                              onConfirmPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      }
                      else{
                        BYRoute.toNamed('/FBlueAddDeviceStep2');
                      }
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
