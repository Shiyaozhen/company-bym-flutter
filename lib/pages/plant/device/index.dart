import 'package:BYM/components/ByDialog.dart';
import 'package:BYM/get_pages.dart';
import 'package:BYM/utils/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../index.dart';

class Device extends StatefulWidget {
  const Device(
      {Key? key, required this.arguments, required this.onHideElements})
      : super(key: key);

  final Map<String, dynamic> arguments;
  final Function(bool) onHideElements;

  @override
  State<Device> createState() => _DeviceState();
}

class DeviceInfo {
  String no;
  String status;
  String loop;
  String energy;
  bool isCheck = false;
  DeviceInfo(this.no, this.status, this.loop, this.energy, this.isCheck);
}

class _DeviceState extends State<Device> {
  TextEditingController _controllerDevice = TextEditingController();
  int selectedIndex = 0;
  int all = 100;
  int wifi_gateway = 10;
  int gateway = 30;
  List<DeviceInfo> deviceList = [
    DeviceInfo('A0010107', '0', '', '20.11', false),
    DeviceInfo('C0010107', '1', '', '20.11', false),
    DeviceInfo('C0010107', '2', '', '20.11', false),
    DeviceInfo('A0010108', '0', '', '20.11', false),
    DeviceInfo('A0010108', '1', '', '20.11', false),
    DeviceInfo('A0010108', '2', '', '20.11', false),
    DeviceInfo('90010109', '0', '', '20.11', false),
    DeviceInfo('90010109', '1', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
    DeviceInfo('A0010109', '2', '', '20.11', false),
  ];
  int selectedLength = 0;
  late String stationName;

  @override
  void initState() {
    super.initState();
    stationName = widget.arguments['stationName'] ?? '';
  }

  bool flag = false;
  void changeText() {
    setState(() {
      stationName = '已选择${selectedLength}';
      flag = true;
    });
  }

  Widget build(BuildContext context) {
    final text = widget.arguments['stationName'];

    void delete() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ByDialog(
            titleText: '温馨提示',
            contentText: '是否确认删除设备',
            cancelText: '取消',
            confirmText: '确认',
            onCancelPressed: () {
              Navigator.of(context).pop();
            },
            onConfirmPressed: () {
              setState(() {
                flag = false;
                stationName = text;
              });
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD6DDFF),
        title: Column(
          children: [
            Text(
              stationName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        centerTitle: true,
        leading: Row(
          children: [
            Visibility(
                visible: !flag,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: const Color(0xFF383838),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Visibility(
                visible: flag,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: const Color(0xFF383838),
                  onPressed: () {
                    setState(() {
                      flag = false;
                      stationName = text;
                      widget.onHideElements(false);
                    });
                  },
                ))
          ],
        ),
        actions: [
          Visibility(
            visible: !flag,
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: const Color(0xFF383838),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 1],
                colors: [
                  const Color(0xFFD6DDFF),
                  const Color(0xFFFFFFFF),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Container(
                        height: 40,
                        child: TextField(
                          controller: _controllerDevice,
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
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0; // 更新选中索引为第一个Container
                        });
                      },
                      child: Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: selectedIndex == 0
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
                              all.toString(),
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
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: selectedIndex == 1
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
                              wifi_gateway.toString(),
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
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: selectedIndex == 2
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
                              gateway.toString(),
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
                ),
              ),
              SizedBox(
                height: 22.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: deviceList.length ~/ 2,
                  itemBuilder: (context, index) {
                    int firstIndex = index * 2;
                    int secondIndex = index * 2 + 1;
                    return Row(
                      children: [
                        Flexible(
                          flex: 10,
                          child: GestureDetector(
                            onTap: () {
                              if (!flag) {
                                BYRoute.toNamed('/MIList',arguments: {'EMUId':deviceList[firstIndex].no});
                              }
                            },
                            onLongPress: () {
                              widget.onHideElements(true);
                              changeText();
                              for (int i = 0; i < deviceList.length; i++) {
                                deviceList[i].isCheck = false;
                              }
                              selectedLength = 0;
                              selectedLength++;
                              stationName = '已选择${selectedLength}';
                              deviceList[firstIndex].isCheck = true;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 19.0,
                                    bottom: 19.0,
                                    left: 16.0,
                                    right: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: deviceList[firstIndex]
                                                      .no
                                                      .substring(0, 1) ==
                                                  'A',
                                              child: Image.asset(
                                                'assets/ic_signle_mi.png',
                                                width: 25.8,
                                                height: 40,
                                              ),
                                            ),
                                            Visibility(
                                              visible: deviceList[firstIndex]
                                                      .no
                                                      .substring(0, 1) ==
                                                  'C',
                                              child: Image.asset(
                                                'assets/ic_wifi_mi.png',
                                                width: 51.75,
                                                height: 40,
                                              ),
                                            ),
                                            Visibility(
                                              visible: deviceList[firstIndex]
                                                      .no
                                                      .substring(0, 1) ==
                                                  '9',
                                              child: Image.asset(
                                                'assets/ic_emu.png',
                                                width: 39.01,
                                                height: 40,
                                              ),
                                            )
                                          ],
                                        ),
                                        // 在线、故障等状态
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: flag &&
                                                  deviceList[firstIndex]
                                                          .isCheck ==
                                                      false,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.check_circle,
                                                  size: 30,
                                                ),
                                                color: const Color(0xFFD4DBED),
                                                onPressed: () {
                                                  setState(() {
                                                    selectedLength++;
                                                    stationName =
                                                        '已选择${selectedLength}';
                                                    deviceList[firstIndex]
                                                        .isCheck = true;
                                                  });
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: flag &&
                                                  deviceList[firstIndex]
                                                          .isCheck ==
                                                      true,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.check_circle,
                                                  size: 30,
                                                ),
                                                color: const Color(0xFF5475F7),
                                                onPressed: () {
                                                  setState(() {
                                                    selectedLength--;
                                                    stationName =
                                                        '已选择${selectedLength}';
                                                    deviceList[firstIndex]
                                                        .isCheck = false;
                                                  });
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: deviceList[firstIndex]
                                                          .status ==
                                                      '0' &&
                                                  !flag,
                                              child: Container(
                                                width: 40,
                                                height: 21,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Color(0xFF5475F7),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '在线',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: deviceList[firstIndex]
                                                          .status ==
                                                      '1' &&
                                                  !flag,
                                              child: Container(
                                                width: 40,
                                                height: 21,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Color(0xFFFF7979),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '故障',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: deviceList[firstIndex]
                                                          .status ==
                                                      '2' &&
                                                  !flag,
                                              child: Container(
                                                width: 40,
                                                height: 21,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Color(0xFFAAAAAA),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '离线',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        deviceList[firstIndex].no,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Baseline(
                                          baselineType: TextBaseline.alphabetic,
                                          baseline: 20,
                                          child: SvgPicture.asset(
                                            'assets/ic_plant_energy_day.svg',
                                            width: 16.0,
                                            height: 16.0,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '0.00',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                  color: Color(0xFF939393)),
                                        ),
                                        Text(
                                          'kWh',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.copyWith(
                                                  color: Color(0xFF939393)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (secondIndex < deviceList.length)
                          Flexible(
                            flex: 10,
                            child: GestureDetector(
                              onLongPress: () {
                                widget.onHideElements(true);
                                changeText();
                                for (int i = 0; i < deviceList.length; i++) {
                                  deviceList[i].isCheck = false;
                                  if (deviceList[i].isCheck == true) {
                                    selectedLength++;
                                  }
                                }
                                selectedLength = 0;
                                selectedLength++;
                                stationName = '已选择${selectedLength}';
                                deviceList[secondIndex].isCheck = true;
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 19.0,
                                      bottom: 19.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Visibility(
                                                visible: deviceList[firstIndex]
                                                        .no
                                                        .substring(0, 1) ==
                                                    'A',
                                                child: Image.asset(
                                                  'assets/ic_signle_mi.png',
                                                  width: 25.8,
                                                  height: 40,
                                                ),
                                              ),
                                              Visibility(
                                                visible: deviceList[firstIndex]
                                                        .no
                                                        .substring(0, 1) ==
                                                    'C',
                                                child: Image.asset(
                                                  'assets/ic_wifi_mi.png',
                                                  width: 51.75,
                                                  height: 40,
                                                ),
                                              ),
                                              Visibility(
                                                visible: deviceList[firstIndex]
                                                        .no
                                                        .substring(0, 1) ==
                                                    '9',
                                                child: Image.asset(
                                                  'assets/ic_emu.png',
                                                  width: 39.01,
                                                  height: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // 在线、故障等状态
                                          Row(
                                            children: [
                                              Visibility(
                                                visible: flag &&
                                                    deviceList[secondIndex]
                                                            .isCheck ==
                                                        false,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.check_circle,
                                                    size: 30,
                                                  ),
                                                  color:
                                                      const Color(0xFFD4DBED),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedLength++;
                                                      stationName =
                                                          '已选择${selectedLength}';
                                                      deviceList[secondIndex]
                                                          .isCheck = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: flag &&
                                                    deviceList[secondIndex]
                                                            .isCheck ==
                                                        true,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.check_circle,
                                                    size: 30,
                                                  ),
                                                  color:
                                                      const Color(0xFF5475F7),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedLength--;
                                                      stationName =
                                                          '已选择${selectedLength}';
                                                      deviceList[secondIndex]
                                                          .isCheck = false;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Visibility(
                                                visible: deviceList[secondIndex]
                                                            .status ==
                                                        '0' &&
                                                    !flag,
                                                child: Container(
                                                  width: 40,
                                                  height: 21,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Color(0xFF5475F7),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '在线',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: deviceList[secondIndex]
                                                            .status ==
                                                        '1' &&
                                                    !flag,
                                                child: Container(
                                                  width: 40,
                                                  height: 21,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Color(0xFFFF7979),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '故障',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: deviceList[secondIndex]
                                                            .status ==
                                                        '2' &&
                                                    !flag,
                                                child: Container(
                                                  width: 40,
                                                  height: 21,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Color(0xFFAAAAAA),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '离线',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          deviceList[secondIndex].no,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Baseline(
                                            baselineType:
                                                TextBaseline.alphabetic,
                                            baseline: 20,
                                            child: SvgPicture.asset(
                                              'assets/ic_plant_energy_day.svg',
                                              width: 16.0,
                                              height: 16.0,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            '0.00',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                    color: Color(0xFF939393)),
                                          ),
                                          Text(
                                            'kWh',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                    color: Color(0xFF939393)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Visibility(
                  visible: flag,
                  child: Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => {
                            setState(() {
                              delete();
                            })
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                child: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  color: const Color(0xFFFF7979),
                                  onPressed: () {},
                                ),
                              ),
                              Text(
                                '删除设备',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFFFF7979)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}







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
            icon: Icon(Icons.arrow_back),
            color: Color(0xFF383838),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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

class ApList extends StatelessWidget {
  const ApList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(
      builder: (_) => Expanded(
        child: ListView.builder(
          controller: _.scrollController,
          itemCount: _.apList.length,
          itemBuilder: (context, index) {
            var ap = _.apList[index];

            return InkWell(
              onTap: () {
                BYRoute.toNamed(
                  '/APInfo',
                  arguments: {
                    // "plantId": ap['plantId'],
                    "serialNo": ap['serialNo'],
                  },
                );
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
                        Icon(ap['status'] == 0
                            ? Icons.wifi
                            : ap['status'] == 1
                                ? Icons.error_outline
                                : Icons.wifi_off),
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

