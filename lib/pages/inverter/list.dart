import 'package:BYM/get_pages.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/api/inverter.dart';

// 控制器
class InverterListController extends GetxController {
  String plantId = Get.arguments['plantId'];
  String accessPointId = Get.arguments['accessPointId'];
  String serialNo = Get.arguments['serialNo'];

  int allNum = 0;
  int onlineNum = 0;
  int offlineNum = 0;
  int faultNum = 0;

  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;
  List inverterList = [];
  void getInverterList() async {
    isLoading = true;
    update();

    // 请求列表
    var res = await inverterApi.queryInverter(plantId: plantId, accessPointId: accessPointId, page: page);
    // 请求对应功率、发电量
    List serialNos = res['data']['content'].map((item) => item['serialNo'] as String).toList();
    var data = await inverterApi.currentInvertersEvent(serialNos);
    Map map = {};
    for (var item in data['data']) {
      map[item['inverterSerialNo']] = item;
    }

    isLoading = false;

    inverterList.addAll([
      for (var item in res['data']['content'])
        {
          ...item,
          "power": map[item['serialNo']]['power'],
          "energy": map[item['serialNo']]['dailyEnergy'],
        }
    ]);

    page++;

    update();
  }

  @override
  void onInit() {
    getInverterList();

    super.onInit();
  }
}

// 主体
class InverterList extends StatelessWidget {
  const InverterList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InverterListController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6DDFF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              BYRoute.back();
            },
          ),
          title: Text(_.serialNo),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1.2],
              colors: [
                Color(0xFFD6DDFF),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: const Column(
            children: [
              // StatusBar(),
              // SizedBox(height: 12),
              ItList(),
            ],
          ),
        ),
      ),
    );
  }
}

// 状态栏
class StatusBar extends StatelessWidget {
  const StatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InverterListController>(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatusItem(label: '全部', value: _.allNum, color: const Color(0xFF383838)),
          const SizedBox(width: 12),
          StatusItem(label: '在线', value: _.onlineNum, color: const Color(0xFF5475F7)),
          const SizedBox(width: 12),
          StatusItem(label: '离线', value: _.offlineNum, color: const Color(0xFFAAAAAA)),
          const SizedBox(width: 12),
          StatusItem(label: '故障', value: _.faultNum, color: const Color(0xFFFF7979)),
        ],
      ),
    );
  }
}

// 状态栏 -> 状态项
class StatusItem extends StatelessWidget {
  const StatusItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Text('$value', style: TextStyle(color: color)),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}

// 列表
class ItList extends StatelessWidget {
  const ItList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InverterListController>(
      builder: (_) => Expanded(
        child: ListView.builder(
          controller: _.scrollController,
          itemCount: _.inverterList.length + 1,
          itemBuilder: (context, index) {
            if (index == _.inverterList.length) {
              return _.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            }

            var inverter = _.inverterList[index];

            return GestureDetector(
              onTap: () {
                BYRoute.toNamed(
                  '/InverterDetail',
                  arguments: {
                    "serialNo": inverter['serialNo']
                  },
                );
              },
              onLongPress: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // 编号 状态
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('MI'),
                            const SizedBox(width: 10),
                            Text(inverter['serialNo']),
                          ],
                        ),
                        StatusIcon(status: inverter['status']),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 功率
                    Row(
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(width: 6),
                        Text('当前功率'),
                        SizedBox(width: 40),
                        Text(convertPower(inverter['power'], decimalDigits: 3)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 发电量
                    Row(
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(width: 6),
                        Text('当日发电量'),
                        SizedBox(width: 40),
                        Text(convertEnergy(inverter['energy'], decimalDigits: 8)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 列表 -> 状态图标
class StatusIcon extends StatelessWidget {
  const StatusIcon({super.key, required this.status});

  final int status;

  @override
  Widget build(BuildContext context) {
    Icon icon;

    switch (status) {
      case 0:
        icon = const Icon(Icons.wifi, color: Color(0xFF5475F7));
        break;
      case 1:
        icon = const Icon(Icons.error_outline, color: Color(0xFFFF7979));
        break;
      case 3:
        icon = const Icon(Icons.wifi_off, color: Color(0xFFAAAAAA));
        break;
      default:
        icon = const Icon(Icons.wifi_off, color: Color(0xFFAAAAAA));
    }

    return icon;
  }
}

