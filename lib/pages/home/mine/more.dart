import 'package:BYM/components/ByDialog.dart';
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
            style: Theme.of(context).textTheme.headlineSmall,
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
                            title: Text(items[index],
                                style: Theme.of(context).textTheme.headlineSmall),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF383838),
                              size: 18.0,
                            ),
                            onTap: () {
                              switch (index) {
                                case 0:
                                  BYRoute.toNamed('/FeedBack', arguments: {});
                                  break;
                                case 1:
                                  BYRoute.toNamed('/MineLogoff', arguments: {});
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
            child: ElevatedButton(
               style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5F7FF)), // 覆盖背景色
          ),
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
                child: Text(
                  '退出登录',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF5733),
                      ),
                ),
              ),
          ),
        ]));
  }
}
