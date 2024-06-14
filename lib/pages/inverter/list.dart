import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InverterListController extends GetxController {
  // String accessPointName = Get.arguments['accessPointName'];

  int allNum = 0;
  int onlineNum = 0;
  int offlineNum = 0;
  int faultNum = 0;
}

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
          title: Text('_.accessPointName'),
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
              StatusBar(),
              ItList(),
            ],
          ),
        ),
      ),
    );
  }
}

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

class ItList extends StatelessWidget {
  const ItList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (_) => Expanded(
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              onLongPress: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    // 编号 状态
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('MI'),
                            SizedBox(width: 10),
                            Text('40010107'),
                          ],
                        ),
                        Icon(Icons.wifi, color: Color(0xFF5475F7)),
                      ],
                    ),
                    SizedBox(height: 12),
                    // 功率
                    Row(
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(width: 6),
                        Text('当前功率'),
                        SizedBox(width: 40),
                        Text('0'),
                      ],
                    ),
                    SizedBox(height: 12),
                    // 发电量
                    Row(
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(width: 6),
                        Text('当日发电量'),
                        SizedBox(width: 40),
                        Text('0'),
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

// 状态图标
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

