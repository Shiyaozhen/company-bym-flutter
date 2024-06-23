import 'dart:core';
import 'package:BYM/api/statistics.dart';
import 'package:BYM/generated/l10n.dart';
import 'package:BYM/components/ByDashedLine.dart';
import 'package:BYM/components/ByDayPicker.dart';
import 'package:BYM/components/ByMask.dart';
import 'package:BYM/components/ByMonthPicker.dart';
import 'package:BYM/components/ByWeekPicker.dart';
import 'package:BYM/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:BYM/api/overview.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:BYM/components/by_bar_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 控制器类，状态以及状态的修改在这里定义
class OverviewController extends GetxController {
  static OverviewController get instance => Get.find();

  // 当前功率 装机容量
  var power = '0.00';
  var capacity = '0.00';
  getPowerAndCapacity() async {
    var res = await overviewApi.fetchPowerAndCapacity();

    power = convertPower(res['data']['currentPower']);
    capacity = convertPower(res['data']['capacity']);

    update();
  }

  // 发电量
  var energyDay = '0.00';
  var energyMonth = '0.00';
  var energyAll = '0.00';
  getEnergySummary() async {
    var res = await overviewApi.fetchEnergySummary();

    energyDay = convertEnergy(res['data']['dayEnergy']);
    energyMonth = convertEnergy(res['data']['monthEnergy']);
    energyAll = convertEnergy(res['data']['totalEnergy']);

    update();
  }

  // 状态数量
  var onlineNum = '0';
  var offlineNum = '0';
  var faultNum = '0';
  getInverterStatus() async {
    var res = await overviewApi.fetchInverterStatusSummary();

    onlineNum = res['data']['online'].toString();
    offlineNum = res['data']['offline'].toString();
    faultNum = res['data']['fault'].toString();

    update();
  }

  // 图表
  DateTime day = DateTime.now();
  String yearMonth = '';
  String year = '';
  List chartDataDay = <Map<String, dynamic>>[];
  List chartDataMonth = <Map<String, dynamic>>[];
  List chartDataYear = <Map<String, dynamic>>[];
  void getStatisticsDay() async {
    var res = await statisticsApi.getUserDailyStatistics(dateTime2String(day));
    chartDataDay = [
      for (var i = 0; i < res['data'].length; i++)
        {
          'x': i,
          'y': res['data'][i]['energy'] == null ? 0 : double.parse(res['data'][i]['energy'].toStringAsFixed(2)),
        }
    ];
    update();
  }
  void getStatisticsMonth() async {
    var res = await statisticsApi.getUserMonthlyStatistics(yearMonth);
    chartDataMonth = [
      for (var i = 0; i < res['data'].length; i++)
        {
          'x': i,
          'y': res['data'][i]['energy'] == null ? 0 : double.parse(res['data'][i]['energy'].toStringAsFixed(2)),
        }
    ];
    update();
  }
  void getStatisticsYear() async {
    var res = await statisticsApi.getUserYearlyStatistics(year);
    chartDataYear = [
      for (var i = 0; i < res['data'].length; i++)
        {
          'x': i,
          'y': res['data'][i]['energy'] == null ? 0 : double.parse(res['data'][i]['energy'].toStringAsFixed(2)),
        }
    ];
    update();
  }

  String dateTime2String(
      DateTime dateTime, {
        String format = 'yyyy-MM-dd',
      }) {
    final DateFormat formatter = DateFormat(format);

    return formatter.format(dateTime);
  }

  @override
  void onInit() {
    yearMonth = dateTime2String(DateTime.now(), format: 'yyyy-MM');
    year = dateTime2String(DateTime.now(), format: 'yyyy');

    getPowerAndCapacity();
    getEnergySummary();
    getInverterStatus();
    getStatisticsDay();
    getStatisticsMonth();
    getStatisticsYear();

    super.onInit();
  }
}

class OverViewIndex extends StatefulWidget {
  const OverViewIndex({super.key});

  @override
  State<OverViewIndex> createState() => _OverViewIndexState();
}

class _OverViewIndexState extends State<OverViewIndex> {
  Map<int, Widget> segments = {
    0: Text(S.current.day),
    1: Text(S.current.month),
    2: Text(S.current.year),
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
              maxHeight: MediaQuery.of(context).size.height * 0.64,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DayPicker(
                      onConfirm: (startDay) {
                        print('Selected Week: $startDay');
                      },
                    ),
                  )
                ],
              ),
            ));
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
              maxHeight: MediaQuery.of(context).size.height * 0.64,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: WeekPicker(
                      onConfirm: (startOfWeek, endOfWeek) {
                        print('Selected Week: $startOfWeek - $endOfWeek');
                      },
                    ),
                  )
                ],
              ),
            ));
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
            ));
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
    DateTime endOfWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday - 1));
    String formattedDateSWeek = "${startOfWeek.year}.${startOfWeek.month}.${startOfWeek.day}";
    String formattedDateEWeek = "${endOfWeek.year}.${endOfWeek.month}.${endOfWeek.day}";

    return GuidedOverlay(
      showOverlay: false, // 是否展示新手引导蒙版
      child: Scaffold(
        body: Stack(
          children: [
            // 渐变色背景
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.83],
                  colors: [
                    Color(0xFFD6DDFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 13.0,
                right: 13.0,
              ),
              child: SingleChildScrollView(
                child: GetBuilder<OverviewController>(
                  init: OverviewController(),
                  builder: (_) => Column(
                    children: [
                      // 添加按钮
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(80, 40),
                          ),
                          child: const Row(
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
                      PowerSection(power: _.power, capacity: _.capacity),
                      EnergySection(
                        energyDay: _.energyDay,
                        energyMonth: _.energyMonth,
                        energyAll: _.energyAll,
                      ),
                      StatusSection(
                        onlineNum: _.onlineNum,
                        offlineNum: _.offlineNum,
                        abnormalNum: _.faultNum,
                      ),
                      // 发电量统计
                      Padding(
                        padding: const EdgeInsets.only(top: 19.0, bottom: 19.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // 标题
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
                                      S.of(context).power_generation_statistics,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  )
                                ],
                              ),
                              // 日期选择
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    double segmentedButtonWidth =
                                        constraints.maxWidth * 0.9;
                                    return SizedBox(
                                      width: segmentedButtonWidth,
                                      height: 50,
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: CupertinoSegmentedControl(
                                          children: segments,
                                          onValueChanged: (value) {
                                            setState(() {
                                              currentSegment = value;
                                            });
                                          },
                                          groupValue: currentSegment,
                                          unselectedColor:
                                              const Color(0xFFF5F7FF),
                                          selectedColor:
                                              const Color(0xFF5475F7),
                                          borderColor: Colors.transparent,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // 日
                              Visibility(
                                visible: currentSegment == 0,
                                child: Column(
                                  children: [
                                    // 日期选择
                                    InkWell(
                                      onTap: changeDay,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            formattedDateDay,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                  color:
                                                      const Color(0xFF939393),
                                                ),
                                          ),
                                          const Icon(
                                            Icons.expand_more,
                                            size: 24,
                                            color: Color(0xFF939393),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ByBarChart(data: _.chartDataDay),
                                  ],
                                ),
                              ),
                              // 月
                              Visibility(
                                visible: currentSegment == 1,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: changeWeek,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            formattedDateSWeek,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                color: Color(0xFF939393)),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            size: 24,
                                            color: Color(0xFF939393),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 3.0, right: 8.0),
                                            color: Color(0xFF939393),
                                            // 背景色
                                            child: SizedBox(
                                              width: 20,
                                              height: 1.6,
                                            ),
                                          ),
                                          Text(
                                            formattedDateEWeek,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                color: Color(0xFF939393)),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            size: 24,
                                            color: Color(0xFF939393),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ByBarChart(data: _.chartDataMonth),
                                  ],
                                ),
                              ),
                              // 年
                              Visibility(
                                visible: currentSegment == 2,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: changeMonth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            formattedDateMonth,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                    color: Color(0xFF939393)),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            size: 24,
                                            color: Color(0xFF939393),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ByBarChart(data: _.chartDataYear),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

// 当前功率 装机容量
class PowerSection extends StatelessWidget {
  const PowerSection({
    super.key,
    required this.power,
    required this.capacity,
  });

  final String power;
  final String capacity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 当前功率、装机容量
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //当前功率
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      'assets/ic_current_power.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).current_power,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                          color: Color(0xFF939393),
                        ),
                      ),
                      Text(
                        power,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                            fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              //装机容量
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      'assets/ic_capacity.svg',
                      width: 30,
                      height: 18.09,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).installed_capacity,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                            color: Color(
                                0xFF939393)),
                      ),
                      Text(
                        capacity,
                        style: Theme.of(
                            context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                            fontSize:
                            24.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // 图片
          Expanded(
            child: Image.asset(
              'assets/ic_photovoltaic_panels.png',
              width: 160,
              height: 114.02,
            ),
          ),
        ],
      ),
    );
  }
}

// 发电量
class EnergySection extends StatelessWidget {
  const EnergySection({
    super.key,
    required this.energyDay,
    required this.energyMonth,
    required this.energyAll,
  });

  final String energyDay;
  final String energyMonth;
  final String energyAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).current_power_generation,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                    color: const Color(0xFF939393),
                    fontSize: 13.0),
              ),
              const SizedBox(height: 6,),
              Text(
                energyDay,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                    fontSize: 18.0),
              ),
            ],
          ),
          const DashLine(height: 50,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).power_generation_for_the_current_month,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                    color:
                    Color(0xFF939393),
                    fontSize: 13.0),
              ),
              const SizedBox(height: 6,),
              Text(
                energyMonth,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                    fontSize: 18.0),
              ),
            ],
          ),
          const DashLine(height: 50,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).cumulative_power_generation,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                    color:
                    Color(0xFF939393),
                    fontSize: 13.0),
              ),
              const SizedBox(height: 6,),
              Text(
                '$energyAll',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(
                    fontSize: 18.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 在线、离线、故障数
class StatusSection extends StatelessWidget {
  const StatusSection({
    super.key,
    required this.onlineNum,
    required this.offlineNum,
    required this.abnormalNum,
  });

  final String onlineNum;
  final String offlineNum;
  final String abnormalNum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21.0),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi, color: ByColors.primaryColor),
                const SizedBox(height: 12),
                Text(
                  S.of(context).online_equipment,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                      fontSize: 14.0,
                      color: Color(0xFF939393)),
                ),
                const SizedBox(height: 12),
                Text(
                  onlineNum,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 20.0),
                ),
              ],
            ),
            const DashLine(height: 60,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: ByColors.defaultColor),
                const SizedBox(height: 12),
                Text(
                  S.of(context).offline_equipment,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                      fontSize: 14.0,
                      color: Color(0xFF939393)),
                ),
                const SizedBox(height: 12),
                Text(
                  offlineNum,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 20.0),
                ),
              ],
            ),
            const DashLine(height: 60,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info_outline, color: ByColors.dangerColor),
                const SizedBox(height: 12),
                Text(
                  S.of(context).abnormal_equipment,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                      fontSize: 14.0,
                      color: Color(0xFF939393)),
                ),
                const SizedBox(height: 12),
                Text(
                  abnormalNum,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 20.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 虚线
class DashLine extends StatelessWidget {
  const DashLine({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
      height: height,
      child: CustomPaint(
        painter: DashedLinePainter(),
      ),
    );
  }
}




