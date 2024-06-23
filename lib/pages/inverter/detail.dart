import 'package:BYM/api/access_point.dart';
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

  Map<String, dynamic> powerGenerationData = {
    "power": '',
    "standardPower": '',
    "energyDay": '',
    "energyAll": '',
  };

  Map<String, dynamic> basicData = {
    "model": '',
    "status": 0,
    "plantName": '',
    "primaryVersion": '',
    "secondaryVersion": '',
  };

  Map<String, dynamic> communicationModuleData = {
    "softVersion": '',
    "hardVersion": '',
  };

  void getInverterDetail() async {
    if(RegExp(r'^[A-E]').hasMatch(serialNo)) {
      var runtimeRes = await accessPointApi.fetchAccessPointRuntime([serialNo]);
      var runtimeData = runtimeRes['data'].isNotEmpty ? runtimeRes['data'][0] : null;
      powerGenerationData['power'] = runtimeData?['power'].toString();
      powerGenerationData['energyDay'] = runtimeData?['dailyEnergy'].toString();
      powerGenerationData['energyAll'] = runtimeData?['totalEnergy'].toString();
      update();


      var accessPointData = (await accessPointApi.fetchAccessPointDetail(serialNo))['data'];
      communicationModuleData['softVersion'] = accessPointData['softVersion'];
      communicationModuleData['hardVersion'] = accessPointData['hardVersion'];

      update();

      var accessPointStatusData = (await accessPointApi.fetchAccessPointStatus(serialNo))['data'];

    } else {

    }

    var inverterData = (await inverterApi.queryInverterDetail(serialNo))['data'];
    powerGenerationData['standardPower'] = inverterData['standardPower'].toString();
    basicData['model'] = inverterData['model'];
    basicData['status'] = inverterData['status'];
    basicData['plantName'] = inverterData['plantName'];
    basicData['primaryVersion'] = inverterData['primaryVersion'];
    basicData['secondaryVersion'] = inverterData['secondaryVersion'];

    /*DateTime date = DateTime.fromMicrosecondsSinceEpoch(int.parse(res['data']['createAt']));
    String year = "${date.year}";
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    String second = date.second.toString().padLeft(2, '0');
    updateTime = "$year-$month-$day $hour:$minute:$second";*/

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
                // 发电信息
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
                          const Text('发电信息'),
                          IconButton(
                            onPressed: () {
                              BYRoute.toNamed(
                                '/InverterChart',
                                arguments: {
                                  "serialNo": _.serialNo,
                                },
                              );
                            },
                            icon: const Icon(Icons.navigate_next),
                          ),
                        ],
                      ),
                      InfoItem(label: '当前功率', value: convertPower(_.powerGenerationData['power'])),
                      InfoItem(label: '标称功率', value: '${_.powerGenerationData['standardPower']} W'),
                      InfoItem(label: '当日发电量', value: convertEnergy(_.powerGenerationData['energyDay'])),
                      InfoItem(label: '累计发电量', value: convertEnergy(_.powerGenerationData['energyAll'])),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // 基本信息
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('基本信息'),
                      InfoItem(label: '型号', value: '${_.basicData['model']}'),
                      const StatusItem(),
                      InfoItem(label: '所属电站', value: '${_.basicData['plantName']}'),
                      InfoItem(label: '更新时间', value: ' '),
                      InfoItem(label: '原边版本号', value: '${_.basicData['primaryVersion']}'),
                      InfoItem(label: '副边版本号', value: '${_.basicData['secondaryVersion']}'),
                    ],
                  ),
                ),
                // 通讯模组信息
                Visibility(
                  visible: RegExp(r'^[A-E]').hasMatch(_.serialNo),
                  child: Column(
                    children: [
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
                            const Text('通讯模组信息'),
                            InfoItem(label: '软件版本号', value: _.communicationModuleData['softVersion']),
                            InfoItem(label: '硬件版本号', value: _.communicationModuleData['hardVersion']),
                          ],
                        ),
                      ),
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
        icon = const Icon(Icons.wifi_off, color: Color(0xFFAAAAAA));
        break;
      case 1:
        icon = const Icon(Icons.wifi, color: Color(0xFF5475F7));
        break;
      case 9:
        icon = const Icon(Icons.error_outline, color: Color(0xFFFF7979));
        break;
      default:
        icon = const Icon(Icons.wifi_off, color: Color(0xFFAAAAAA));
    }

    return icon;
  }
}
