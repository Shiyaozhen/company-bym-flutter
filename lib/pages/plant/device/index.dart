import 'package:BYM/get_pages.dart';
import 'package:BYM/themes/colors.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../index.dart';

// 主体
class AccessPointList extends StatelessWidget {
  const AccessPointList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6DDFF),
          title: Text(
            _.isDelete ? '已选择 ${_.deleteAccessPointList.length}' : _.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
          leading: _.isDelete ? const SizedBox() : IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFF383838),
            onPressed: () {
              BYRoute.back();
            },
          ),
          actions: [
            _.isDelete
                ? IconButton(
                    onPressed: () {
                      _.deleteAccessPointList.clear();
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
        bottomNavigationBar: _.isDelete ? const DeleteButton() : NavigationBar(
          backgroundColor: ByColors.bottomNavigationBarColor,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _.currentPageIndex,
          onDestinationSelected: (int index) {
            _.switchPageIndex(index);
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.offline_bolt),
              icon: Icon(Icons.offline_bolt_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.widgets),
              icon: Icon(Icons.widgets_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings_applications),
              icon: Icon(Icons.settings_applications_outlined),
              label: '',
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 13.0, right: 13.0),
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
              /*SearchBar(),
              SizedBox(height: 12.0),
              TypeBar(),
              SizedBox(
                height: 22.0
              ),*/
              ApList(),
            ],
          ),
        ),
      ),
    );
  }
}

// 搜索框
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(builder: (_) => TextField(
      controller: _.apNoTC,
      decoration: InputDecoration(
        hintText: '输入设备编号',
        hintStyle: TextStyle(
          color: const Color(0xFF7989B2),
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 24,
        ),
        prefixIconColor: const Color(0xFF7989B2),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0),
      ),
    ));
  }
}

// 接入点类型
class TypeBar extends StatelessWidget {
  const TypeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(builder: (_) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _.switchType(0);
          },
          child: Container(
            width: 110,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: _.type == 0
                    ? const Color(0xFF5475F7)
                    : Colors.white,
                width: 1.0,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _.apAllNum.toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  '全部',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _.switchType(1);
          },
          child: Container(
            width: 110,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: _.type == 1
                    ? const Color(0xFF5475F7)
                    : Colors.white,
                width: 1.0,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_.apWifiNum}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  'Wi-Fi微逆',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _.switchType(2);
          },
          child: Container(
            width: 110,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: _.type == 2
                    ? const Color(0xFF5475F7)
                    : Colors.white,
                width: 1.0,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_.apNum}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  '网关',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

// 接入点列表
class ApList extends StatelessWidget {
  const ApList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(
      builder: (_) => Expanded(
        child: ListView.builder(
          controller: _.scrollController,
          itemCount: _.accessPointList.length + 1,
          itemBuilder: (context, index) {
            if (index == _.accessPointList.length) {
              return _.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            }

            var ap = _.accessPointList[index];

            return GestureDetector(
              onTap: () {
                if(!_.isDelete) {
                  if(ap['type']['value'] == 2) {
                    BYRoute.toNamed(
                      '/AccessPointInfo',
                      arguments: {
                        "serialNo": ap['serialNo'],
                      },
                    );
                  } else {
                    BYRoute.toNamed(
                      '/InverterDetail',
                      arguments: {
                        "serialNo": ap['serialNo'],
                      },
                    );
                  }
                }
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
                              Text(ap['type']['label']),
                              const SizedBox(width: 10),
                              Text(ap['serialNo']),
                            ],
                          ),
                          _.isDelete
                              ? Checkbox(
                                  value: _.deleteAccessPointList.contains(ap['serialNo']) ? true : false,
                                  onChanged: (bool? value) {
                                    _.updateDeleteAccessPointList(ap['serialNo'], value);
                                  },
                                )
                              : StatusIcon(status: ap['status']),
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
                        Text(ap['power']),
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
                        Text(ap['energy']),
                      ],
                    ),
                    // 下挂设备
                    Visibility(
                      visible: ap['type']['value'] == 2,
                      child: Column(
                        children: [
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.black,
                          ),
                          InkWell(
                            onTap: () {
                              if(!_.isDelete) {
                                BYRoute.toNamed(
                                  '/InverterList',
                                  arguments: {
                                    "plantId": ap['plantId'],
                                    "accessPointId": ap['id'],
                                    "serialNo": ap['serialNo'],
                                  },
                                );
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('下挂设备'),
                                Icon(Icons.navigate_next),
                              ],
                            ),
                          ),
                        ],
                      ),
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
    return GetBuilder<PlantDetailController>(
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
    return GetBuilder<PlantDetailController>(
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
                itemCount: _.deleteAccessPointList.length,
                itemBuilder: (context, index) {
                  String key = _.deleteAccessPointList[index];

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
              _.deleteAccessPoint();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}




