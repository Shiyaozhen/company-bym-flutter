import 'dart:io';

import 'package:BYM/components/ByDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({Key? key}) : super(key: key);

  @override
  _ChangeInfoState createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  TextEditingController _controllerPlant = TextEditingController();
  TextEditingController _controllerAccount = TextEditingController();
  TextEditingController _controllerCountry = TextEditingController();
  TextEditingController _controllerTimeZone = TextEditingController();
  bool _showClearPlantButton = false;
  bool _showClearAccountButton = false;
  int CountryIndex = 0;
  int TimeZoneIndex = 0;
  List<File> _images = [];
  int _remainingCharacters = 0;
  TextEditingController _controller = TextEditingController();
  List<String> countries = ['法国', '英国', '美国', '意大利'];
  List<String> timezone = ['UTC-02:00', 'UTC-01:00', 'UTC-04:00', 'UTC-08:00'];
  int selectedIndex = -1;
  Future _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (_images.length < 1) {
          _images.add(File(image.path));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerPlant.addListener(() {
      setState(() {
        _showClearPlantButton = _controllerPlant.text.isNotEmpty;
      });
    });
    _controllerAccount.addListener(() {
      setState(() {
        _showClearAccountButton = _controllerAccount.text.isNotEmpty;
      });
    });
  }

  void _clearPlantTextField() {
    setState(() {
      _controllerPlant.clear();
      _showClearPlantButton = false;
    });
  }

  void _clearAccountTextField() {
    setState(() {
      _controllerAccount.clear();
      _showClearAccountButton = false;
    });
  }

  //选择国家

  void selectCountry() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          ScrollController scrollController = ScrollController();
          return Container(
            width: 350,
            height: 500, 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 19,
                ),
                Text(
                  '选择国家',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            CountryIndex = index;
                          });
                        },
                        child: Container(
                            color: CountryIndex == index
                                ? Color(0xFFF5F7FF)
                                : Colors.transparent,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Align(
                                    alignment: Alignment.center,
                                    child: Text(countries[index]),
                                  ),
                                ),
                                Container(
                                  width: 320,
                                  height: 1,
                                  color: Color(0xFFD4DBED),
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 170,
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _controllerCountry.text = countries[CountryIndex];
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5475F7),
                          minimumSize: Size(80, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(color: Color(0xFF5475F7)),
                          ),
                        ),
                        child: Text(
                          '确定',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  //选择时区

  void selectTimeZone() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          ScrollController scrollController = ScrollController();
          return Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 19,
                ),
                Text(
                  '选择时区',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            TimeZoneIndex = index;
                          });
                        },
                        child: Container(
                            color: TimeZoneIndex == index
                                ? Color(0xFFF5F7FF)
                                : Colors.transparent,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Align(
                                    alignment: Alignment.center,
                                    child: Text(timezone[index]),
                                  ),
                                ),
                                Container(
                                  width: 320,
                                  height: 1,
                                  color: Color(0xFFD4DBED),
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 170,
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _controllerTimeZone.text = timezone[TimeZoneIndex];
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5475F7),
                          minimumSize: Size(80, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(color: Color(0xFF5475F7)),
                          ),
                        ),
                        child: Text(
                          '确定',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  //保存
  void save() {
    if (_controllerPlant.text == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ByDialog(
            titleText: '温馨提示',
            contentText: '电站名称不能为空!',
            cancelText: '',
            confirmText: '确认',
            onCancelPressed: () {
              Navigator.of(context).pop();
            },
            onConfirmPressed: () {
              print("执行退出登录的操作");
              Navigator.of(context).pop();
            },
          );
        },
      );
      return;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '修改信息',
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
      body: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 13.0, right: 13.0),
        child: Column(
          children: [
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 15.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '电站名称',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0, bottom: 22.0),
              child: TextField(
                controller: _controllerPlant,
                decoration: InputDecoration(
                  hintText: '请输入电站名称',
                  suffixIcon: _showClearPlantButton
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Color(0xFF7989B2)),
                          onPressed: _clearPlantTextField,
                        )
                      : null,
                ),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 15.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '国家',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0, bottom: 22.0),
              child: InkWell(
                onTap: selectCountry,
                child: IgnorePointer(
                  child: TextField(
                    controller: _controllerCountry,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: '请选择国家',
                      suffixIcon: Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF7989B2)),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 15.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '时区',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0, bottom: 22.0),
              child: InkWell(
                onTap: selectTimeZone,
                child: IgnorePointer(
                  child: TextField(
                    controller: _controllerTimeZone,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: '请选择时区',
                      suffixIcon: Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF7989B2)),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '图片',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 22.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Wrap(
                      spacing: 3,
                      runSpacing: 3,
                      children: [
                        Visibility(
                          visible: _images.length < 1,
                          child: Container(
                            width: 120,
                            height: 90,
                            margin: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              onPressed: _images.length < 3 ? _pickImage : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF5F7FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xFF7989B2),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        ..._images.map(
                          (image) => Container(
                            width: 120,
                            height: 90,
                            margin: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                Image.file(
                                  width: 120,
                                  height: 90,
                                  image,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _images.remove(image);
                                      });
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ElevatedButton(
              onPressed: () {
                save();
              },
              child: Text('保存',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}




class PlantEditController extends GetxController {
  // 电站名称
  TextEditingController nameTextController = TextEditingController();
  bool showClear = false;
  void clearName() {
    nameTextController.text = '';
    update();
  }

  // 国家
  TextEditingController countryTextController = TextEditingController();
  List countryList = [];

  // 时区
  TextEditingController timezoneTextController = TextEditingController();

  // 图片
  List<File> images = [];

  @override
  void onInit() {
    print(Get.arguments);

    super.onInit();
  }
}

class PlantEdit extends StatelessWidget {
  const PlantEdit({super.key});

  void showCountryList(context) {
    /*showDialog(
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
                Text('选择国家'),
              ],
            ),
          ),
        );
      },
    );*/

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              color: Colors.indigo,
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '修改信息',
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
      body: PlantEditContent(),
    );
  }
}

class PlantEditContent extends StatelessWidget {
  const PlantEditContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantEditController>(
      init: PlantEditController(),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            // 电站名称
            Row(
              children: [
                Text(
                  '*',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.red),
                ),
                const SizedBox(width: 5,),
                Text(
                  '电站名称',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _.nameTextController,
              decoration: InputDecoration(
                hintText: '请输入电站名称',
                suffixIcon: _.showClear
                    ? IconButton(
                  icon: Icon(Icons.clear, color: Color(0xFF7989B2)),
                  onPressed: () {
                    _.clearName();
                  },
                )
                    : null,
              ),
            ),
            const SizedBox(height: 20,),
            // 国家
            Row(
              children: [
                Text(
                  '*',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.red),
                ),
                const SizedBox(width: 5,),
                Text(
                  '国家',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {
                // showCountryList(context);
              },
              child: IgnorePointer(
                child: TextField(
                  controller: _.countryTextController,
                  enabled: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: '请选择国家',
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF7989B2)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            // 时区
            Row(
              children: [
                Text(
                  '*',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.red),
                ),
                const SizedBox(width: 5,),
                Text(
                  '时区',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {},
              child: IgnorePointer(
                child: TextField(
                  controller: _.timezoneTextController,
                  enabled: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: '请选择时区',
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF7989B2)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            // 图片
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '图片',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            /*Padding(
                padding: EdgeInsets.only(top: 22.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Wrap(
                        spacing: 3,
                        runSpacing: 3,
                        children: [
                          Visibility(
                            visible: _images.length < 1,
                            child: Container(
                              width: 120,
                              height: 90,
                              margin: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: _images.length < 3 ? _pickImage : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF5F7FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Color(0xFF7989B2),
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          ..._images.map(
                                (image) => Container(
                              width: 120,
                              height: 90,
                              margin: const EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  Image.file(
                                    width: 120,
                                    height: 90,
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _images.remove(image);
                                        });
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),*/
          ],
        ),
      ),
    );
  }
}


