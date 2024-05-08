import 'package:flutter/material.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '联系我们',
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
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: Center(
                      child: Image.asset(
                        'assets/ic_logo.png',
                        width: 100,
                        height: 80,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)), // 设置圆角
                          child: Container(
                              height: 350,
                              decoration:
                                  BoxDecoration(color: Color(0xFFF5F7FF)),
                              child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Wrap(
                                    spacing: 16.0,
                                    runSpacing: 16.0,
                                    children: [
                                      _buildRowWithUnderline('软件版本号', 'v1.0.0'),
                                      _buildRowWithUnderline(
                                          '邮箱', 'benyi@zjbeny.com'),
                                      _buildRowWithUnderline(
                                          '电话', '+86-577-57177008'),
                                      _buildRowWithUnderline(
                                          '网站', 'www.BENY.com'),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Copyright©2022Zjbeny All Right Rserved.',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF878787),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )))))
                ]))));
  }
}

Widget _buildRowWithUnderline(String leftContent, String rightContent) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            leftContent,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF383838),
            ),
          )),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              rightContent,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF383838),
              ),
            ),
          )),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          height: 1.0,
          color: Color(0xFFE1EAF3),
        ),
      )
    ],
  );
}
