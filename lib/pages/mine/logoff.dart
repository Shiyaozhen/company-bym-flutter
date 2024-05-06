import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MineLogoff extends StatefulWidget {
  const MineLogoff({Key? key}) : super(key: key);

  @override
  _LogoffState createState() => _LogoffState();
}

class _LogoffState extends State<MineLogoff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '账号注销',
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: Center(
                    child: SvgPicture.asset('assets/ic_fail.svg',
                        width: 50, height: 80)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '注销后您的账号将发生如下变化:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '永久注销，无法登录',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '注销本账号后，出法律法规及账号注销协议另有规定外，基于该账号的信息相关数据也将进行删除或者匿名化处理。您无法再检索、访问、获取、继续使用，前述其他信息包括但不限于:头像昵称、或使用中添加的电站信息及微逆信息等内容。',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF939393)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '此账号关联的信息将被删除',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1.该账号下电站数据',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '2.EMU设备数据',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '3.光伏板发电数据',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF383838)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top:20.0),
                  child: ElevatedButton(
                    onPressed: () {
                     BYRoute.toNamed('/ConLogoff');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF5475F8)),
                      foregroundColor:
                          MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      minimumSize:
                          MaterialStateProperty.all(Size.fromHeight(45.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), 
                        ),
                      ),
                    ),
                    child: Text(
                      '我已知晓，确认注销',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '若想恢复数据，请联系平台方.',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF878787)),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
