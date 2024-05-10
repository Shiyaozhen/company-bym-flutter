import 'package:BYM/components/ByMask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverViewIndex extends StatefulWidget {
  const OverViewIndex({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<OverViewIndex> {
  @override
  Widget build(BuildContext context) {
    return GuidedOverlay(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 32.0,
                right: 32.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // 设置背景色
                      minimumSize: Size(80, 40), // 设置按钮最小尺寸
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Color(0xFF5475F7),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween, // 两边对齐
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          //当前功率
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  'assets/ic_current_power.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '当前功率',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2
                                              ?.copyWith(
                                                  color: Color(0xFF939393)),
                                        ),
                                      )),
                                  Container(
                                      width: 100,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '0.00kW',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(fontSize: 24.0),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          //装机容量
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8.0),
                                  child: SvgPicture.asset(
                                    'assets/ic_capacity.svg',
                                    width: 30,
                                    height: 18.09,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '装机容量',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                ?.copyWith(
                                                    color: Color(0xFF939393)),
                                          ),
                                        )),
                                    Container(
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '0.00kW',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                ?.copyWith(fontSize: 24.0),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        'assets/ic_current_power.svg',
                        width: 160,
                        height: 114.02,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )),
      showOverlay: false, // 是否展示新手引导蒙版
    );
  }
}
