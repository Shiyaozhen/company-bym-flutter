import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MineFeedback extends StatefulWidget {
  const MineFeedback({Key? key}) : super(key: key);

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<MineFeedback> {
  List<File> _images = [];
  int _remainingCharacters = 0;

  Future _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (_images.length < 3) {
          _images.add(File(image.path));
        }
      });
    }
  }

  void _updateRemainingCharacters(String text) {
    setState(() {
      _remainingCharacters = 130 - text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '意见反馈',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Color(0xFF383838)),
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '问题及建议',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 100,
                      child: TextField(
                        // controller: _messageController,
                        maxLength: 130,
                        maxLines: null,
                        onChanged: _updateRemainingCharacters,
                        decoration: InputDecoration(
                          counterText: '剩余字符：$_remainingCharacters',
                          filled: true,
                          fillColor: Color(0xFFF5F7FF),
                          border: InputBorder.none,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '上传图片(0/${_images.length})',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Wrap(
                      spacing: 3,
                      runSpacing: 3,
                      children: [
                        Visibility(
                          visible: _images.length < 3,
                          child: Container(
                            width: 80,
                            height: 80,
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
                              ),
                            ),
                          ),
                        ),
                        ..._images.map(
                          (image) => Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                Image.file(
                                  width: 80,
                                  height: 80,
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
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '联系方式',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  maxLength: 130,
                  maxLines: null,
                  onChanged: _updateRemainingCharacters,
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: Color(0xFFF5F7FF),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
              floatingActionButton:  Container(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5475F8)),
                  foregroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(45.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0), // 设置圆角半径为20.0
                    ),
                  ),
                ),
                child: Text('提交',style:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
            )),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}
