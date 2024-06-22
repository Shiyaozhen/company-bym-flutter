import 'package:BYM/api/plant.dart';
import 'package:BYM/api/storage.dart';
import 'package:BYM/components/by_input_field.dart';
import 'package:BYM/get_pages.dart';
import 'package:BYM/themes/colors.dart';
import 'package:BYM/utils/BYLog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio_package;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class PlantEditController extends GetxController {
  var plant = Get.arguments['plant'];

  TextEditingController plantCtl = TextEditingController();

  TextEditingController countryCtl = TextEditingController();
  String country = '';
  Map<String, String> countryMap = {
    "CN": '中国',
    "GB": '英国',
    "FR": '法国',
    "DE": '德国',
    "BR": '巴西',
    "PL": '波兰',
    "ES": '西班牙',
  };

  void updateCountry(entry) {
    country = entry.key;
    countryCtl.text = entry.value;

    update();
  }

  TextEditingController timezoneCtl = TextEditingController();
  List timezoneList = [
    'UTC+00:00',
    'UTC+01:00',
    'UTC+02:00',
    'UTC+03:00',
    'UTC+03:30',
    'UTC+04:00',
    'UTC+04:30',
    'UTC+05:00',
    'UTC+05:30',
    'UTC+06:00',
    'UTC+06:30',
    'UTC+07:00',
    'UTC+08:00',
    'UTC+09:00',
    'UTC+10:00',
    'UTC+11:00',
    'UTC+12:00',
    'UTC-01:00',
    'UTC-02:00',
    'UTC-03:00',
    'UTC-03:30',
    'UTC-04:00',
    'UTC-04:30',
    'UTC-05:00',
    'UTC-05:30',
    'UTC-06:00',
    'UTC-06:30',
    'UTC-07:00',
    'UTC-08:00',
    'UTC-09:00',
    'UTC-10:00',
    'UTC-11:00',
    'UTC-12:00'
  ];

  void updateTimezone(timezone) {
    timezoneCtl.text = timezone;

    update();
  }

  ImagePicker picker = ImagePicker();
  File? image;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void updatePlant() async {
    if (image != null) {
      BYLog.i("image: ${image}");
      String filename = image!.path.split("/").last;
      dio_package.FormData formData = dio_package.FormData.fromMap({
        "image": await dio_package.MultipartFile.fromFile(image!.path,
            filename: filename,
            contentType: MediaType.parse(lookupMimeType(image!.path)!))
      });

      await storageApi.uploadImage(formData);
    }

    /*await plantApi.updatePlant(
      id: plant['id'],
      name: plantCtl.text,
      country: country,
      timezone: timezoneCtl.text,
    );*/
  }

  @override
  void onInit() {
    print(plant);

    plantCtl.text = plant['name'];
    countryCtl.text = countryMap[plant['country']] ?? '';
    timezoneCtl.text = plant['timezone'];

    super.onInit();
  }
}

class PlantEdit extends StatelessWidget {
  const PlantEdit({super.key});

  // 弹出国家列表
  void _showCountryList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<PlantEditController>(
          builder: (_) => Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8, // 设置最大高度
            ),
            padding: const EdgeInsets.only(top: 36, bottom: 12),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _.countryMap.length,
              itemBuilder: (context, index) {
                var entry = _.countryMap.entries.elementAt(index);

                return GestureDetector(
                  onTap: () {
                    _.updateCountry(entry);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: _.country == entry.key ? ByColors.bg1 : null,
                    ),
                    child: Text(entry.value, textAlign: TextAlign.center),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // 弹出时区列表
  void _showTimezoneList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<PlantEditController>(
          builder: (_) => Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8, // 设置最大高度
            ),
            padding: const EdgeInsets.only(top: 36, bottom: 12),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _.timezoneList.length,
              itemBuilder: (context, index) {
                String timezone = _.timezoneList[index];

                return GestureDetector(
                  onTap: () {
                    _.updateTimezone(timezone);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color:
                          _.timezoneCtl.text == timezone ? ByColors.bg1 : null,
                    ),
                    child: Text(timezone, textAlign: TextAlign.center),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlantEditController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '修改信息',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFF383838),
            onPressed: () => BYRoute.back(),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 40, left: 12, right: 12),
          child: ElevatedButton(
            onPressed: () {
              _.updatePlant();
            },
            child: const Text('保存'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('电站名称'),
                const SizedBox(height: 12),
                ByTextField(controller: _.plantCtl),
                const SizedBox(height: 20),
                const Text('国家'),
                const SizedBox(height: 12),
                ByButtonTextField(
                  controller: _.countryCtl,
                  readonly: true,
                  suffix: IconButton(
                    onPressed: () {
                      _showCountryList(context);
                    },
                    icon: const Icon(Icons.expand_more),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('时区'),
                const SizedBox(height: 12),
                ByButtonTextField(
                  controller: _.timezoneCtl,
                  readonly: true,
                  suffix: IconButton(
                    onPressed: () {
                      _showTimezoneList(context);
                    },
                    icon: const Icon(Icons.expand_more),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('图片'),
                const SizedBox(height: 12),
                _.image == null
                    ? GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView(
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: const Text('相册',
                                          textAlign: TextAlign.center),
                                    ),
                                    onTap: () {
                                      _.pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const Divider(indent: 20, endIndent: 20),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: const Text('相机',
                                          textAlign: TextAlign.center),
                                    ),
                                    onTap: () {
                                      _.pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ByColors.bg1,
                          ),
                          child: const Center(
                            child: Icon(Icons.add),
                          ),
                        ),
                      )
                    : Center(
                        child: Image.file(File(_.image!.path)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
