import 'package:BYM/pages/plant/detail/index.dart';
import 'package:BYM/pages/plant/device/index.dart';
import 'package:BYM/utils/unit_converter.dart';
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
  double energyDay = 10;
  double energyMonth = 10;
  double energyAll = 10;
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
  List <Map<String, dynamic>> accessPointList = [];
  List deleteAccessPointList = [];
  void getAccessPointList() async {
    // Loading 转圈
    isLoading = true;
    update();

    // 接入点列表
    var apList = (await accessPointApi.queryAccessPoint(id, apNoTC.text, page))['data']['content'];
    List serialNos = apList.map((item) => item['serialNo'] as String).toList();
    var realTimeDataList = (await accessPointApi.fetchAccessPointRuntime(serialNos))['data'];
    var realTimeDataMap = {
      for (var item in realTimeDataList) item['accessPointSerialNo'] : item
    };

    isLoading = false;

    accessPointList.addAll([
      for (var item in apList) {
        ... item,
        "power": convertPower(realTimeDataMap[item['serialNo']]?['power'], decimalDigits: 6),
        "energy": convertEnergy(realTimeDataMap[item['serialNo']]?['dailyEnergy'], decimalDigits: 6),
      }
    ]);

    page++;

    update();
  }
  void deleteAccessPoint() async {
    print(deleteAccessPointList);
    deleteAccessPointList.clear();
  }
  void updateDeleteAccessPointList(String serialNo, bool? value) {
    if(value == true) {
      deleteAccessPointList.add(serialNo);
    } else {
      deleteAccessPointList.remove(serialNo);
    }
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

class PlantDetail extends StatelessWidget {
  const PlantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlantDetailController(),
      builder: (_) => IndexedStack(
        index: _.currentPageIndex,
        children: const [
          PlantDetailOverview(),
          AccessPointList(),
          PlantMore(),
        ],
      ),
    );
  }
}

