import 'dart:core';

import 'package:BYM/components/ByDashedLine.dart';
import 'package:BYM/components/ByDayPicker.dart';
import 'package:BYM/components/ByMask.dart';
import 'package:BYM/components/ByMonthPicker.dart';
import 'package:BYM/components/ByWeekPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class OverViewIndex extends StatefulWidget {
  const OverViewIndex({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<OverViewIndex> {
  Map<int, Widget> segments = {
    0: Text(
      '日',
    ),
    1: Text('周'),
    2: Text('月')
  };
  int currentSegment = 0;
  //修改日
  void changeDay() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                0.64, // 设置最大高度的比例，此处为屏幕高度的80%
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                // 如果要读上层的变量 可以不用 Flexible
                child: DayPicker(
                  onConfirm: (startDay) {
                    print('Selected Week: $startDay');
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //修改周
  void changeWeek() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                0.64, // 设置最大高度的比例，此处为屏幕高度的80%
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                // 如果要读上层的变量 可以不用 Flexible
                child: WeekPicker(
                  onConfirm: (startOfWeek, endOfWeek) {
                    print('Selected Week: $startOfWeek - $endOfWeek');
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //修改月
  void changeMonth() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.64,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: MonthPicker(
                onConfirm: (startOfMonth, endOfMonth) {
                  print('Selected Week: $startOfMonth - $endOfMonth');
                },
              ))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //日
    DateTime now = DateTime.now();
    String formattedDateDay = "${now.year}.${now.month}.${now.day}";
    //月
    String formattedDateMonth = "${now.year}.${now.month}";
    //周
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday));
    DateTime endOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday - 1));
    String formattedDateSWeek =
        "${startOfWeek.year}.${startOfWeek.month}.${startOfWeek.day}";
    String formattedDateEWeek =
        "${endOfWeek.year}.${endOfWeek.month}.${endOfWeek.day}";
    return GuidedOverlay(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.83],
                colors: [
                  const Color(0xFFD6DDFF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 13.0,
                      right: 13.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(80, 40),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(0xFF5475F7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 24.0, left: 32.0, right: 32.0),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // 两边对齐
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  //当前功率
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8.0),
                                        child: SvgPicture.asset(
                                          'assets/ic_current_power.svg',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: 100,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '当前功率',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2
                                                      ?.copyWith(
                                                          color: Color(
                                                              0xFF939393)),
                                                ),
                                              )),
                                          Container(
                                              width: 100,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .baseline,
                                                    textBaseline:
                                                        TextBaseline.alphabetic,
                                                    children: [
                                                      Baseline(
                                                        baselineType:
                                                            TextBaseline
                                                                .alphabetic,
                                                        baseline: 0.0,
                                                        child: Text(
                                                          '0.00',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          24.0),
                                                        ),
                                                      ),
                                                      Text(
                                                        'kW',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //装机容量
                                  Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 8.0),
                                          child: SvgPicture.asset(
                                            'assets/ic_capacity.svg',
                                            width: 30,
                                            height: 18.09,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                width: 100,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '装机容量',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        ?.copyWith(
                                                            color: Color(
                                                                0xFF939393)),
                                                  ),
                                                )),
                                            Container(
                                                width: 100,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .baseline,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Baseline(
                                                          baselineType:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          baseline: 0.0,
                                                          child: Text(
                                                            '0.00',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        24.0),
                                                          ),
                                                        ),
                                                        Text(
                                                          'kW',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                      ],
                                                    ))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Image.asset(
                                'assets/ic_photovoltaic_panels.png',
                                width: 160,
                                height: 114.02,
                              ),
                            )
                          ],
                        ),
                      ),
                      //日、月、累计发电
                      Padding(
                        padding: EdgeInsets.only(top: 40.0, left: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '当日发电量',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(
                                                  color: Color(0xFF939393),
                                                  fontSize: 13.0),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Baseline(
                                                baselineType:
                                                    TextBaseline.alphabetic,
                                                baseline: 0.0,
                                                child: Text(
                                                  '0.00',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1
                                                      ?.copyWith(
                                                          fontSize: 18.0),
                                                ),
                                              ),
                                              Text(
                                                'kW',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.copyWith(fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Container(
                                            width: 1,
                                            height: 40,
                                            child: CustomPaint(
                                              painter: DashedLinePainter(),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '当月发电量',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  ?.copyWith(
                                                      color: Color(0xFF939393),
                                                      fontSize: 13.0),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 6.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Baseline(
                                                    baselineType:
                                                        TextBaseline.alphabetic,
                                                    baseline: 0.0,
                                                    child: Text(
                                                      '0.00',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              fontSize: 18.0),
                                                    ),
                                                  ),
                                                  Text(
                                                    'kW',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1
                                                        ?.copyWith(
                                                            fontSize: 15.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Container(
                                            width: 1,
                                            height: 40,
                                            child: CustomPaint(
                                              painter: DashedLinePainter(),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '累计发电量',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  ?.copyWith(
                                                      color: Color(0xFF939393),
                                                      fontSize: 13.0),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 6.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Baseline(
                                                    baselineType:
                                                        TextBaseline.alphabetic,
                                                    baseline: 0.0,
                                                    child: Text(
                                                      '0.00',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.copyWith(
                                                              fontSize: 18.0),
                                                    ),
                                                  ),
                                                  Text(
                                                    'kWh',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1
                                                        ?.copyWith(
                                                            fontSize: 15.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //在线、离线、故障数
                      Padding(
                        padding: EdgeInsets.only(top: 21.0),
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 25.0,
                                left: 25.0,
                                top: 22.0,
                                bottom: 22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/ic_device_online.svg',
                                            width: 20,
                                            height: 20),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 6.0, bottom: 15),
                                          child: Text(
                                            '在线设备',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(
                                                    fontSize: 14.0,
                                                    color: Color(0xFF939393)),
                                          ),
                                        ),
                                        Text(
                                          '20',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(fontSize: 20.0),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 60,
                                  child: CustomPaint(
                                    painter: DashedLinePainter(),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/ic_device_offline.svg',
                                            width: 20,
                                            height: 20),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 6.0, bottom: 15),
                                          child: Text(
                                            '离线',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(
                                                    fontSize: 14.0,
                                                    color: Color(0xFF939393)),
                                          ),
                                        ),
                                        Text(
                                          '5',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(fontSize: 20.0),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 60,
                                  child: CustomPaint(
                                    painter: DashedLinePainter(),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/ic_device_fault.svg',
                                            width: 20,
                                            height: 20),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 6.0, bottom: 15),
                                          child: Text(
                                            '异常设备',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(
                                                    fontSize: 14.0,
                                                    color: Color(0xFF939393)),
                                          ),
                                        ),
                                        Text(
                                          '2',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(fontSize: 20.0),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //发电量统计
                      Padding(
                        padding: EdgeInsets.only(top: 19.0, bottom: 19.0),
                        child: Container(
                            height: 853,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/ic_energy_static.svg',
                                        width: 18.0,
                                        height: 18.0,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 6.0),
                                        child: Text(
                                          '发电量统计',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 24.0),
                                      child: LayoutBuilder(
                                        builder: (BuildContext context,
                                            BoxConstraints constraints) {
                                          double segmentedButtonWidth =
                                              constraints.maxWidth * 0.9;
                                          return Container(
                                              width: segmentedButtonWidth,
                                              height: 50,
                                              child: Transform.scale(
                                                scale: 1.2,
                                                child:
                                                    CupertinoSegmentedControl(
                                                  children: segments,
                                                  onValueChanged: (value) {
                                                    setState(() {
                                                      currentSegment = value;
                                                      print(currentSegment);
                                                    });
                                                  },
                                                  groupValue: currentSegment,
                                                  unselectedColor:
                                                      Color(0xFFF5F7FF),
                                                  selectedColor:
                                                      Color(0xFF5475F7),
                                                  borderColor:
                                                      Colors.transparent,
                                                ),
                                              ));
                                        },
                                      )),
                                  Visibility(
                                    visible: currentSegment == 0,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 16.0, bottom: 10.0),
                                        child: InkWell(
                                          onTap: changeDay,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                formattedDateDay,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    ?.copyWith(
                                                        color:
                                                            Color(0xFF939393)),
                                              ),
                                              Icon(
                                                Icons.expand_more,
                                                size: 24,
                                                color: Color(0xFF939393),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Visibility(
                                    visible: currentSegment == 1,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 16.0, bottom: 10.0),
                                        child: InkWell(
                                          onTap: changeWeek,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                formattedDateSWeek,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    ?.copyWith(
                                                        color:
                                                            Color(0xFF939393)),
                                              ),
                                              Icon(
                                                Icons.expand_more,
                                                size: 24,
                                                color: Color(0xFF939393),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 3.0, right: 8.0),
                                                color: Color(0xFF939393), // 背景色
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 1.6,
                                                ),
                                              ),
                                              Text(
                                                formattedDateEWeek,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    ?.copyWith(
                                                        color:
                                                            Color(0xFF939393)),
                                              ),
                                              Icon(
                                                Icons.expand_more,
                                                size: 24,
                                                color: Color(0xFF939393),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Visibility(
                                    visible: currentSegment == 2,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 16.0, bottom: 10.0),
                                        child: InkWell(
                                          onTap: changeMonth,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                formattedDateMonth,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    ?.copyWith(
                                                        color:
                                                            Color(0xFF939393)),
                                              ),
                                              Icon(
                                                Icons.expand_more,
                                                size: 24,
                                                color: Color(0xFF939393),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
      showOverlay: false, // 是否展示新手引导蒙版
    );
  }
}
