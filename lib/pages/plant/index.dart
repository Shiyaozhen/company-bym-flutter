import 'package:BYM/pages/plant/detail/index.dart';
import 'package:BYM/pages/plant/device/index.dart';
import 'more/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/api/plant.dart';
import 'package:BYM/api/access_point.dart';

class PlantDetailController extends GetxController {
  static PlantDetailController get instance => Get.find();

  String id = Get.arguments['id'];
  String name = Get.arguments['name'];

  // 导航栏
  int currentPageIndex = 0;
  void switchPageIndex(index) {
    currentPageIndex = index;
    update();
  }

  // 首页
  double power = 0;
  double capacity = 0;
  double ratio = 0;
  int energyDay = 10;
  int energyMonth = 10;
  int energyAll = 10;
  void getPower() async{
    var res = await plantApi.fetchPlantPowerSummary(id);

    power = res['data']['currentPower'];
    capacity = res['data']['capacity'];
    ratio = double.parse((power / capacity).toStringAsFixed(2));

    update();
  }
  void getEnergy() async{
    var res = await plantApi.fetchPlantEnergySummary(id);

    energyDay = res['data']['dayEnergy'];
    energyMonth = res['data']['monthEnergy'];
    energyAll = res['data']['totalEnergy'];

    update();
  }

  // 接入点列表
  bool isDelete = false;
  void switchIsDelete(value) {
    isDelete = value;
    update();
  }
  TextEditingController apNoTC = TextEditingController();
  int apAllNum = 0;
  int apWifiNum = 0;
  int apNum = 0;
  int type = 0;
  void switchType(index) {
    type = index;
    update();
  }
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isLoading = false;
  List <Map<String, dynamic>> accessPointList = [
    {
      "serialNo": '90000181',
      "type": {
        "value": 2,
        "label": 'PLCC',
      },
      "power": 0,
      "energy": 0,
      "status": 0,
      "isSelected": false,
    },
    {
      "serialNo": 'A0000001',
      "type": {
        "value": 1,
        "label": 'PLCC',
      },
      "power": 0,
      "energy": 0,
      "status": 1,
      "isSelected": false,
    },
    {
      "serialNo": '90000181',
      "type": {
        "value": 2,
        "label": 'PLCC',
      },
      "power": 0,
      "energy": 0,
      "status": 3,
      "isSelected": false,
    },
  ];
  void getAccessPointList() async {
    isLoading = true;
    update();

    var res = accessPointApi.queryAccessPoint(id, apNoTC.text, page);

    isLoading = false;

    accessPointList.addAll([
      for (var item in res['data']['content']) item
    ]);

    page++;

    update();
  }
  void deleteAccessPoint() async {
    List deleteAccessPointList = accessPointList.where((ap) => ap['isSelected'] == true).toList();

    print(deleteAccessPointList);
  }
  void switchIsSelected(int index, bool? value) {
    accessPointList[index]['isSelected'] = value;
    update();
  }


  // 更多
  bool isEnable = false;
  void switchAntiBackFlow(value) {
    isEnable = value;
    update();
  }

  @override
  void onInit() {
    getPower();
    getEnergy();

    getAccessPointList();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && isLoading == false) {
        getAccessPointList();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    apNoTC.dispose();

    super.onClose();
  }
}

class PlantDetail extends StatefulWidget {
  const PlantDetail({super.key});

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  bool shouldHideElements = false;
  void toggleHideElements(bool shouldHide) {
    setState(() {
      shouldHideElements = shouldHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String stationName = arguments['name'];

    return GetBuilder(
      init: PlantDetailController(),
      builder: (_) => Scaffold(
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _.currentPageIndex,
          onDestinationSelected: (int index) {
            _.switchPageIndex(index);
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.commute),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: '',
            ),
          ],
        ),
        body: IndexedStack(
          index: _.currentPageIndex,
          children: [
            PlantDetailOverview(),
            AccessPointList(),
            PlantMore(),
          ],
        ),
      ),
    );
  }
}


