import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({Key? key}) : super(key: key);

  @override
  _ChangeInfoState createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  TextEditingController _controllerPlant = TextEditingController();
  TextEditingController _controllerAccount = TextEditingController();
  bool _showClearPlantButton = false;
  bool _showClearAccountButton = false;
  List<File> _images = [];
  int _remainingCharacters = 0;

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
  void selectCountry(){
    
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
        padding:
            EdgeInsets.only(top: 16.0, bottom: 16.0, left: 13.0, right: 13.0),
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
              child: TextField(
                enabled: false,
                // controller: _controller,
                decoration: InputDecoration(
                    hintText: '请选择国家',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF7989B2)),
                      onPressed: selectCountry,
                    )),
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
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: '请选择时区',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF7989B2)),
                      onPressed: _clearPlantTextField,
                    )),
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
              padding: EdgeInsets.only(top: 10.0),
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
              onPressed: () {},
              child: Text('保存',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
