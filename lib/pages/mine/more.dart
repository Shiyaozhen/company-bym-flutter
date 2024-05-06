import 'package:BYM/components/ByDialog.dart';
import 'package:BYM/pages/mine/logoff.dart';
import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';

class MineMore extends StatelessWidget {
  final List<String> items = ['意见反馈', '注销账户'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '',
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
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              items[index],
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF383838),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF383838),
                              size: 14.0,
                            ),
                            onTap: () {
                              switch (index) {
                                case 0:
                                  BYRoute.toNamed('/FeedBack');
                                  break;
                                case 1:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MineLogoff()),
                                  );
                                  break;
                                default:
                                  break;
                              }
                              print('点击了列表项 $index');
                            },
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              width: double.infinity,
                              height: 0.4,
                              color: Color(0xFFE1EAF3),
                            ),
                          ),
                        ],
                      );
                    },
                  ))),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 16.0),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ByDialog(
                        titleText: '退出登录',
                        contentText: '您确定要退出登录吗？',
                        cancelText: '取消',
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
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFF5F7FF)),
                  foregroundColor: MaterialStateProperty.all(Color(0xFFFF5733)),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(45.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 设置圆角半径为20.0
                    ),
                  ),
                ),
                child: Text(
                  '退出登录',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]));
  }
}
