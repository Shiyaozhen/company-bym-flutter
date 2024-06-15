import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';

import 'package:BYM/get_pages.dart';
import 'package:get/get.dart';
import 'package:BYM/api/inverter.dart';

class InverterDetailController extends GetxController {
  String serialNo = Get.arguments['serialNo'];

  double power = 0;
  double capacity = 0;
  double energyDay = 0;
  double energyAll = 0;

  int type = -1;
  int status = 0;
  String plantName = '';
  String updateTime = '';
  String primaryVersion = '';
  String secondaryVersion = '';
  String hardVersion = '';

  void getInverterDetail() async {
    var res = await inverterApi.queryInverterDetail(serialNo);

    capacity = res['data']['standardPower'];

    type = res['data']['type']['value'];
    status = res['data']['status'];
    plantName = res['data']['plantName'] ?? '';
    primaryVersion = res['data']['primaryVersion'];
    secondaryVersion = res['data']['secondaryVersion'];

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(int.parse(res['data']['createAt']));
    String year = "${date.year}";
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    String second = date.second.toString().padLeft(2, '0');
    updateTime = "$year-$month-$day $hour:$minute:$second";

    update();
  }

  @override
  void onInit() {
    getInverterDetail();

    super.onInit();
  }
}

// 主体
class InverterDetail extends StatelessWidget {
  const InverterDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InverterDetailController(),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('发电信息'),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.navigate_next)),
                        ],
                      ),
                      InfoItem(label: '当前功率', value: convertPower(_.power)),
                      InfoItem(label: '标称功率', value: '${_.capacity} W'),
                      InfoItem(label: '当日发电量', value: convertEnergy(_.energyDay)),
                      InfoItem(label: '累计发电量', value: convertEnergy(_.energyAll)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('基本信息'),
                      InfoItem(label: '类型', value: '${_.type}'),
                      StatusItem(),
                      InfoItem(label: '所属电站', value: _.plantName),
                      InfoItem(label: '更新时间', value: _.updateTime),
                      InfoItem(label: '原边版本号', value: _.primaryVersion),
                      InfoItem(label: '副边版本号', value: _.secondaryVersion),
                      InfoItem(label: '硬件版本号', value: _.hardVersion),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 信息项
class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}

// 状态
class StatusItem extends StatelessWidget {
  const StatusItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InverterDetailController>(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('状态'),
                StatusIcon(status: _.status),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PV1原边故障代码: 0000'),
                      SizedBox(height: 6),
                      Text('PV1原边故障: 电网电压频率异常'),
                      SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ),
          ],
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
