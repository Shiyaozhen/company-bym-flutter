import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MIDetail extends StatefulWidget {
  const MIDetail({super.key, required this.arguments});

  final Map<String, dynamic> arguments;
  @override
  State<MIDetail> createState() => _MIDetailState();
}

class _MIDetailState extends State<MIDetail> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String MIId = arguments['MIId'];
    print(MIId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F7FF),
          title: Column(
            children: [
              Text(
                MIId,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          centerTitle: true,
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFF383838),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xFFF5F7FF)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, right: 13, left: 13),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MIModelWidget(),
                    SizedBox(
                      height: 25.0,
                    ),
                    EnergyWidget(),
                    SizedBox(
                      height: 20.0,
                    ),
                    BaseWidget(),
                    SizedBox(
                      height: 20.0,
                    ),
                    OtherWidget(),
                    SizedBox(
                      height: 20.0,
                    ),
                    AllWidgetState(),
                    SizedBox(
                      height: 20.0,
                    ),
                    DeleteWidgetState()
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
//单路
class MICommonModelWidget extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Column(
    );
  }


}
//四路微型逆变器
class MIModelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/ic_mi_online_bg.png',
                    width: 80,
                    height: 80,
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Column(
                        children: [
                          Text(
                            '100.00',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'w',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/ic_mi_offline_bg.png',
                    width: 80,
                    height: 80,
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Column(
                        children: [
                          Text(
                            '100.00',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'w',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_miw_connect.png',
              width: 224.0,
              height: 80,
            )
          ],
        ),
             Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/ic_mi_fault_gray_bg.png',
                    width: 80,
                    height: 80,
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Column(
                        children: [
                          Text(
                            '100.00',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'w',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/ic_mi_fault_bg.png',
                    width: 80,
                    height: 80,
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Column(
                        children: [
                          Text(
                            '100.00',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'w',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

//日、月发电量
class EnergyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Expanded(
            child: Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 19.0, right: 19.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/ic_plant_energy_day.svg'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '日发电量',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Color(0xFF939393)),
                    ),
                    Row(
                      children: [
                        Baseline(
                          baseline: 32.0,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            '00.00',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Baseline(
                          baseline: 32.0,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            'kWh',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
            child: Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 19.0, right: 19.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/ic_plant_energy_month.svg'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '月发电量',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Color(0xFF939393)),
                    ),
                    Row(
                      children: [
                        Baseline(
                          baseline: 32.0,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            '00.00',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Baseline(
                          baseline: 32.0,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            'kWh',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ))
      ],
    ));
  }
}

//基本信息
class BaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 13.0, right: 13.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '基础信息',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 22.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '状态',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFF5475F7),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      '在线',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Color(0xFFF5F7FF),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '类型',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                  Text(
                    'MI-W',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Color(0xFFF5F7FF),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pri.Ver',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                  Text(
                    '1.00',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Color(0xFFF5F7FF),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sec.Ver',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                  Text(
                    '4.05',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Color(0xFF939393)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//其他信息
class OtherWidget extends StatefulWidget {
  @override
  _OtherWidgetState createState() => _OtherWidgetState();
}

class _OtherWidgetState extends State {
  @override
  bool _switch = false;
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 13.0, right: 13.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '其他信息',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: 22.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '所属电站',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Color(0xFF939393)),
                ),
                Text(
                  'Plant-2024-04-26-02',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Color(0xFF939393)),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Color(0xFFF5F7FF),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '更新时间',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Color(0xFF939393)),
                ),
                Text(
                  '2024-05-16 15:28:40',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Color(0xFF939393)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Color(0xFFF5F7FF),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '防逆流',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Color(0xFF939393)),
                ),
                Switch(
                  value: _switch,
                  activeColor: Color(0xFF5475F7),
                  onChanged: (value) {
                    setState(() {
                      _switch = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

//累计发电量
class AllWidgetState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 13.0, right: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/ic_plant_energy_total.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text('累计发电量',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF939393)))
                    ],
                  ),
                  Row(
                    children: [
                      Text('00.00',
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text(
                        'kWh',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Icon(Icons.arrow_right, color: Color(0xFFD4DBED)),
                    ],
                  )
                ],
              ),
            )));
  }
}

//删除设备
class DeleteWidgetState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Center(
          child: Padding(
        padding:
            EdgeInsets.only(top: 16.0, bottom: 16.0, left: 13.0, right: 13.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline,
                color: Color(0xFFFF7979),
                size: 26,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '删除设备',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Color(0xFFFF7979)),
              )
            ],
          ),
        ),
      )),
    );
  }
}
