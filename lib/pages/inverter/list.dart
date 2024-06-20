import 'package:BYM/get_pages.dart';
import 'package:BYM/themes/colors.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/api/inverter.dart';

// 控制器
class InverterListController extends GetxController {
  String plantId = Get.arguments['plantId'];
  String accessPointId = Get.arguments['accessPointId'];
  String serialNo = Get.arguments['serialNo'];

  bool isDelete = false;
  void switchIsDelete(bool value) {
    isDelete = value;
    update();
  }

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
    var data = await inverterApi.queryInverterRuntime(serialNos);
    Map map = {};
    for (var item in data['data']) {
      map[item['inverterSerialNo']] = item;
    }

    isLoading = false;

    inverterList.addAll([
      for (var item in res['data']['content'])
        {
          ...item,
          "power": map.isNotEmpty ? map[item['serialNo']]['power'] : 0,
          "energy": map.isNotEmpty ? map[item['serialNo']]['dailyEnergy'] : 0,
        }
    ]);

    page++;

    update();
  }
  List deleteInverterList = [];
  void deleteInverter() async {
    print(deleteInverterList);
    deleteInverterList.clear();
    isDelete = false;
    update();
  }
  void updateDeleteInverterList(String serialNo, bool? value) {
    if(value == true) {
      deleteInverterList.add(serialNo);
    } else {
      deleteInverterList.remove(serialNo);
    }
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
          leading: _.isDelete
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    BYRoute.back();
                  },
                ),
          title: _.isDelete ? Text("已选择 ${_.deleteInverterList.length}") : Text(_.serialNo),
          actions: [
            _.isDelete
                ? IconButton(
                    onPressed: () {
                      _.switchIsDelete(false);
                    },
                    icon: const Icon(Icons.check),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline),
                  ),
          ],
        ),
        bottomNavigationBar: _.isDelete ? const DeleteButton() : null,
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
          StatusBarItem(label: '全部', value: _.allNum, color: const Color(0xFF383838)),
          const SizedBox(width: 12),
          StatusBarItem(label: '在线', value: _.onlineNum, color: const Color(0xFF5475F7)),
          const SizedBox(width: 12),
          StatusBarItem(label: '离线', value: _.offlineNum, color: const Color(0xFFAAAAAA)),
          const SizedBox(width: 12),
          StatusBarItem(label: '故障', value: _.faultNum, color: const Color(0xFFFF7979)),
        ],
      ),
    );
  }
}

// 状态栏 -> 状态项
class StatusBarItem extends StatelessWidget {
  const StatusBarItem({
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
              onLongPress: () {
                _.switchIsDelete(true);
              },
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
                    SizedBox(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(inverter['type']['label']),
                              const SizedBox(width: 10),
                              Text(inverter['serialNo']),
                            ],
                          ),
                          _.isDelete ? Checkbox(
                            value: _.deleteInverterList.contains(inverter['serialNo']) ? true : false,
                            onChanged: (bool? value) {
                              _.updateDeleteInverterList(inverter['serialNo'], value);
                            },
                          ) : StatusIcon(status: inverter['status']),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // 功率
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Icon(Icons.add_circle),
                              SizedBox(width: 6),
                              Text('当前功率'),
                            ],
                          ),
                        ),
                        Text(convertPower(inverter['power'], decimalDigits: 3)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 发电量
                    Row(
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Icon(Icons.add_circle),
                              SizedBox(width: 6),
                              Text('当日发电量'),
                            ],
                          ),
                        ),
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
        icon = const Icon(Icons.wifi, color: ByColors.primaryColor);
        break;
      case 1:
        icon = const Icon(Icons.error_outline, color: ByColors.dangerColor);
        break;
      case 3:
        icon = const Icon(Icons.wifi_off, color: ByColors.defaultColor);
        break;
      default:
        icon = const Icon(Icons.wifi_off, color: ByColors.defaultColor);
    }

    return icon;
  }
}

// 删除按钮
class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InverterListController>(
      builder: (_) => GestureDetector(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => const DeleteDialog(),
          );
        },
        child: Container(
          height: 80,
          color: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline, color: ByColors.dangerColor),
              SizedBox(
                width: 12,
              ),
              Text(
                '删除设备',
                style: TextStyle(color: ByColors.dangerColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 确认删除对话框
class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InverterListController>(
      builder: (_) => AlertDialog(
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(
            maxHeight: 700,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('是否确认删除设备:'),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _.deleteInverterList.length,
                itemBuilder: (context, index) {
                  String key = _.deleteInverterList[index];

                  return Text(key);
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _.deleteInverter();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

