import 'package:BYM/get_pages.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../index.dart';

// 接入点列表页面主体
class AccessPointList extends StatelessWidget {
  const AccessPointList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6DDFF),
          title: Text(
            _.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFF383838),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            _.isDelete
                ? IconButton(
                    onPressed: () {
                      _.switchIsDelete(false);
                      _.deleteAccessPoint();
                    },
                    icon: const Icon(Icons.check),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline),
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
          itemCount: _.accessPointList.length,
          itemBuilder: (context, index) {
            var ap = _.accessPointList[index];

            return GestureDetector(
              onTap: () {
                if(ap['type']['value'] == 2) {
                  BYRoute.toNamed(
                    '/AccessPointInfo',
                    arguments: {
                      // "plantId": ap['plantId'],
                      "serialNo": ap['serialNo'],
                    },
                  );
                } else {
                  BYRoute.toNamed(
                    '/InverterDetail',
                  );
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(ap['type']['value'] == 1 ? 'MI-W' : 'PLCC'),
                            const SizedBox(width: 10),
                            Text(ap['serialNo']),
                          ],
                        ),
                        _.isDelete
                            ? Checkbox(
                                value: ap['isSelected'],
                                onChanged: (bool? value) {
                                  _.switchIsSelected(index, value);
                                },
                              )
                            : StatusIcon(status: ap['status']),
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
                        Text(convertPower(ap['power'])),
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
                        Text(convertPower(ap['energy'])),
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
                              BYRoute.toNamed(
                                '/InverterList',
                              );
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


