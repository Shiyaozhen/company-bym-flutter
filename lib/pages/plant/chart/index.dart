import 'package:BYM/api/plant.dart';
import 'package:BYM/components/by_bar_chart.dart';
import 'package:BYM/components/by_calendar.dart';
import 'package:BYM/get_pages.dart';
import 'package:BYM/themes/colors.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 控制器
class PlantChartController extends GetxController {
  String id = '915';
  // String id = Get.arguments['id'];
  // String name = Get.arguments['name'];

  int currentIndex = 0;
  void switchCalendarView(int index) {
    currentIndex = index;
    update();
  }

  String day = '2024-06-20';
  String month = '2024-06';
  String year = '2024';

  String energyDay = '';
  String energyMonth = '';
  String energyYear = '';

  List chartDataDay = [];
  List chartDataMonth = [];
  List chartDataYear = [];
  void getChartDataDay() async {
    var data = (await plantApi.fetchPlantChartDataDay(plantId: id, date: day))['data'];

    chartDataDay = [
      for(var item in data)
        {
          "x": item['intervalTime'].substring(11, 13),
          "y": item['energy'] ?? 0,
        }
    ];

    update();
  }
  void getChartDataMonth() async {
    var data = (await plantApi.fetchPlantChartDataMonth(plantId: id, date: month))['data'];

    chartDataMonth = [
      for(var item in data)
        {
          "x": item['intervalTime'].substring(8, 10),
          "y": item['energy'] ?? 0,
        }
    ];

    update();
  }
  void getChartDataYear() async {
    var data = (await plantApi.fetchPlantChartDataYear(plantId: id, date: year))['data'];

    chartDataYear = [
      for(var item in data)
        {
          "x": item['intervalTime'].substring(5, 7),
          "y": item['energy'] ?? 0,
        }
    ];

    update();
  }

  @override
  void onInit() {
    getChartDataDay();
    getChartDataMonth();
    getChartDataYear();

    super.onInit();
  }
}

// 主体
class PlantChart extends StatelessWidget {
  const PlantChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlantChartController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => BYRoute.back(),
              icon: const Icon(Icons.arrow_back)),
          title: Text('_.name'),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // 日期类型选择
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton<int>(
                      segments: const <ButtonSegment<int>>[
                        ButtonSegment<int>(
                          value: 0,
                          label: Text('日'),
                        ),
                        ButtonSegment<int>(
                          value: 1,
                          label: Text('月'),
                        ),
                        ButtonSegment<int>(
                          value: 2,
                          label: Text('年'),
                        ),
                      ],
                      selected: <int>{_.currentIndex},
                      onSelectionChanged: (Set<int> newSelection) {
                        _.switchCalendarView(newSelection.first);
                      },
                      showSelectedIcon: false,
                      style: SegmentedButton.styleFrom(
                        backgroundColor: ByColors.color1,
                        selectedBackgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              <Widget>[
                const ChartDay(),
                const ChartMonth(),
                const ChartYear(),
              ][_.currentIndex],
            ],
          ),
        ),
      ),
    );
  }
}

// 日
class ChartDay extends StatelessWidget {
  const ChartDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantChartController>(
      builder: (_) => Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 日期选择
            Row(
              children: [
                Text(_.day),
                IconButton(
                  onPressed: () {
                    /*showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ByPickerDay(callback: (dateTime) {});
                      },
                    );*/


                  },
                  icon: const Icon(Icons.expand_more),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // 发电量
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ByColors.defaultColor,
                  width: 1,
                )
              ),
              child: Column(
                children: [
                  Text(convertEnergy(_.energyDay)),
                  const SizedBox(height: 12),
                  const Text('日发电量'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // 图表
            ByBarChart(data: _.chartDataDay),
          ],
        ),
      ),
    );
  }
}

// 月
class ChartMonth extends StatelessWidget {
  const ChartMonth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantChartController>(
      builder: (_) => Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 日期选择
            Row(
              children: [
                Text(_.month),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ByPickerMonth(
                          year: _.month.split('-')[0],
                          month: _.month.split('-')[1],
                          callback: (year, month) {
                            _.month = '$year-$month';
                            _.getChartDataMonth();
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.expand_more),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // 发电量
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ByColors.defaultColor,
                    width: 1,
                  )
              ),
              child: Column(
                children: [
                  Text(convertEnergy(_.energyMonth)),
                  const SizedBox(height: 12),
                  const Text('月发电量'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // 图表
            ByBarChart(data: _.chartDataMonth),
          ],
        ),
      ),
    );
  }
}

// 年
class ChartYear extends StatelessWidget {
  const ChartYear({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantChartController>(
      builder: (_) => Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 日期选择
            Row(
              children: [
                Text('${_.year}'),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ByPickerYear(year: _.year, callback: (year) {
                          _.year = year;
                          _.getChartDataYear();
                        });
                      },
                    );
                  },
                  icon: const Icon(Icons.expand_more),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // 发电量
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ByColors.defaultColor,
                    width: 1,
                  )
              ),
              child: Column(
                children: [
                  Text(convertEnergy(_.energyYear)),
                  const SizedBox(height: 12),
                  const Text('年发电量'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // 图表
            ByBarChart(data: _.chartDataYear),
          ],
        ),
      ),
    );
  }
}
