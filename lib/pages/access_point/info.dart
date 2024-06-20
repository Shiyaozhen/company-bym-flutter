import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/api/access_point.dart';

class AccessPointController extends GetxController {
  String serialNo = Get.arguments['serialNo'];

  void getAccessPointDetail() async {
    var data = (await accessPointApi.fetchAccessPointDetail(serialNo))['data'];

    await accessPointApi.fetchAccessPointRuntime([serialNo]);

    await accessPointApi.fetchAccessPointStatus(serialNo);

  }

  @override
  void onInit() {
    getAccessPointDetail();

    super.onInit();
  }
}

class AccessPointInfo extends StatelessWidget {
  const AccessPointInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AccessPointController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(_.serialNo),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF5F7FF),
        body: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('基本信息'),
              AccessPointInfoItem(label: '类型', value: 'EMU'),
              AccessPointInfoItem(label: '信号强度', value: '-100'),
              AccessPointInfoItem(label: '运行模式', value: 'PLCC透传模式'),
              AccessPointInfoItem(label: '功能码', value: '00'),
              AccessPointInfoItem(label: '当前功率', value: '0 KW'),
              AccessPointInfoItem(label: '当日发电量', value: '0 kWh'),
              AccessPointInfoItem(label: '更新时间', value: '2024-6-7'),
            ],
          ),
        ),
      ),
    );
  }
}

class AccessPointInfoItem extends StatelessWidget {
  const AccessPointInfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(value),
            ],
          ),
        ),
        const Divider(height: 20, thickness: 1, color: Color(0xFFF5F7FF),),
      ],
    );
  }
}
