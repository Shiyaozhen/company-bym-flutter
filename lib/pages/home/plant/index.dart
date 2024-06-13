import 'package:BYM/get_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:BYM/api/plant.dart';
import 'package:BYM/utils/unit_converter.dart';

// 控制器类
class PlantController extends GetxController {
  int selectedItem = 0;

  int plantNum = 0;
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> plantList = [];
  bool isLoading = false;
  int page = 1;
  String name = '';
  void getPlantList() async {
    isLoading = true;
    update();

    var res = await plantApi.queryPlant(page: page, name: name);

    isLoading = false;

    plantNum = int.parse(res['data']['totalElements']);
    plantList.addAll([
      for (var item in res['data']['content']) item
    ]);

    page++;

    update();
  }

  TextEditingController textEditingController = TextEditingController();
  bool isObscure = true;
  void changeObscure() {
    isObscure = !isObscure;
    update();
  }

  @override
  void onInit() {
    getPlantList();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && isLoading == false) {
        getPlantList();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    textEditingController.dispose();

    super.onClose();
  }
}

class PlantListPage extends StatelessWidget {
  const PlantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.83],
          colors: [
            Color(0xFFD6DDFF),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: GetBuilder<PlantController>(
        init: PlantController(),
        builder: (_) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('电站数量: ${_.plantNum}'),
                PopupMenuButton<int>(
                  initialValue: _.selectedItem,
                  onSelected: (int item) {
                    print(item);
                    _.selectedItem = item;
                    print(_.selectedItem);
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(Icons.add_circle_outline),
                          SizedBox(width: 3,),
                          Text('添加设备'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.qr_code_scanner_outlined),
                          SizedBox(width: 3,),
                          Text('扫一扫'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                controller: _.scrollController,
                itemCount: _.plantList.length,
                itemBuilder: (context, index) {
                  var plant = _.plantList[index];

                  if (index == _.plantList.length - 1) {
                    return _.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }

                  return InkWell(
                    onTap: () {
                      BYRoute.toNamed('/PowerStationIndex', arguments: {"stationName": _.plantList[index]['name']});
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          // 图片 状态
                          Stack(
                            alignment: Alignment.center, // 文字居中
                            children: [
                              Image.asset(
                                'assets/ic_plant_avatar.png',
                                width: 70,
                                height: 70,
                              ),
                              Positioned(
                                bottom: 2,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5475F7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 3, bottom: 5, left: 7, right: 7),
                                      child: Text('在线',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                              color: Color(0xFFFFFFFF))),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // 电站名称 功率 装机容量
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(plant['name']),
                                    MoreButton(plant: plant),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            width: 12,
                                            height: 12,
                                            'assets/ic_current_power.svg',
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            '当前功率',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                color: Color(0xFF939393)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(convertPower(plant['currentPower']),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            width: 12,
                                            height: 7.23,
                                            'assets/ic_capacity.svg',
                                          ),
                                          Text(
                                            '装机容量',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                              color: Color(0xFF939393),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(convertEnergy(plant['capacity']),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ],
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
          ],
        ),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    required this.plant,
  });

  final Map<String, dynamic> plant;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantController>(
      builder: (_) => IconButton(
        icon: const Icon(Icons.more_horiz_outlined),
        tooltip: '更多',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                alignment: Alignment.bottomCenter,
                insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // 这里添加圆角
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 电站图片
                      Image.asset(
                        'assets/ic_plant_avatar.png',
                        width: 70,
                        height: 70,
                      ),
                      // 电站名称
                      Text(
                        plant['name'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      // 编辑电站
                      TextButton(
                        onPressed: () {
                          BYRoute.toNamed('/PlantEdit', arguments: plant);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF5475F7)),
                        ),
                        child: const Text('修改信息'),
                      ),
                      // 删除电站
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return DeleteDialog(plant: plant,);
                            },
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFF5222D)),
                        ),
                        child: const Text('删除'),
                      ),
                      // 取消
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('取消'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.plant,
  });

  final Map<String, dynamic> plant;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantController>(
      builder: (_) => Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10), // 这里添加圆角
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '删除电站',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20,),
              Text(
                '电站删除后，电站下的设备和数据会被清 除,为了您的账号安全请输入登录密码.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _.textEditingController,
                obscureText: _.isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        _.isObscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      _.changeObscure();
                    },
                  ),
                  hintText: '请输入您的密码',
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('取消'),
                  ),
                  const SizedBox(width: 10,),
                  FilledButton(
                    onPressed: () {
                      var id = plant['id'];

                      plantApi.deletePlant(id);

                      Navigator.pop(context);
                    },
                    child: const Text('确定'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
