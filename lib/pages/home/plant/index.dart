import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantIndex extends StatefulWidget {
  const PlantIndex({super.key});

  @override
  _IndexState createState() => _IndexState();
}

//电站列表
class Plant {
  String name;
  Plant(this.name);
}

class _IndexState extends State<PlantIndex> {
  TextEditingController _controllerPlant = TextEditingController();
  int selectedIndex = 0;
  int all = 100;
  int online = 10;
  int offline = 30;
  int fault = 40;
  bool isObscure = true;
  bool isKeyboardVisible = false;
  //电站列表
  List<Plant> plantList = [
    Plant('快乐星球'),
    Plant('啊哈哈哈哈'),
    Plant('Pla-0-26-02'),
    Plant('打撒废了'),
    Plant('个个都是'),
    Plant('借古讽今'),
  ];

  Widget build(BuildContext context) {
    print(plantList.length);
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.83],
            colors: [
              const Color(0xFFD6DDFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
      ),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20.0,
                left: 16,
                right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 290,
                      height: 40,
                      child: TextField(
                        controller: _controllerPlant,
                        decoration: InputDecoration(
                          hintText: '输入电站名称',
                          hintStyle:
                              TextStyle(color: Color(0xFF7989B2), fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 24,
                          ),
                          prefixIconColor: Color(0xFF7989B2),
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                      ),
                    ),
                    InkWell(onTap: ()=>{
                      BYRoute.toNamed('/Scan')
                    },child: SvgPicture.asset(
                        width: 36, height: 36, 'assets/ic_plant_more.svg'),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0; // 更新选中索引为第一个Container
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: selectedIndex == 0
                                    ? Color(0xFF5475F7)
                                    : Colors.white,
                                width: 1.0,
                              ),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(all.toString(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                              Text(
                                '全部',
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: selectedIndex == 1
                                    ? Color(0xFF5475F7)
                                    : Colors.white,
                                width: 1.0,
                              ),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(online.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: Color(0xFF5475F7))),
                              Text('在线',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: Color(0xFF5475F7)))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: selectedIndex == 2
                                    ? Color(0xFF5475F7)
                                    : Colors.white,
                                width: 1.0,
                              ),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(offline.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: Color(0xFFAAAAAA))),
                              Text('离线',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: Color(0xFFAAAAAA)))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 3;
                          });
                        },
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: selectedIndex == 3
                                    ? Color(0xFF5475F7)
                                    : Colors.white,
                                width: 1.0,
                              ),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(fault.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: Color(0xFFFF7979))),
                              Text('故障',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: Color(0xFFFF7979)))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: plantList.length == 0,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: 450,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset('assets/ic_plant_add.svg'),
                                Text(
                                  '暂无设备，请添加',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: Color(0xFF878787)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                Visibility(
                    visible: plantList.length > 0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                          height: 500,
                          child: Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: plantList.length,
                              itemBuilder: (context, index) {
                                Plant plant = plantList[index];
                                return InkWell(onTap: (){
                                  print(plant.name);
                                     BYRoute.toNamed('/PowerStationIndex', arguments: {'stationName': plant.name});
                                },child: Container(
                                    width: 380,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    margin: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 0, right: 0),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 12, right: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3,
                                                          bottom: 5,
                                                          left: 7,
                                                          right: 7),
                                                      child: Text('在线',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium
                                                              ?.copyWith(
                                                                  color: Color(
                                                                      0xFFFFFFFF))),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Container(
                                                    width: 220,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(plant.name),
                                                        InkWell(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  width: 350,
                                                                  height: 300,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            20),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            plant.name,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                Theme.of(context).textTheme.headlineMedium,
                                                                          ),
                                                                          Padding(
                                                                              padding: EdgeInsets.only(top: 39),
                                                                              child: InkWell(
                                                                                  onTap: () {},
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.pop(context);
                                                                                      BYRoute.toNamed('/ChangeInfo', arguments: {});
                                                                                    },
                                                                                    child: Text(
                                                                                      '修改信息',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Color(0xFF5475F7)),
                                                                                    ),
                                                                                  ))),
                                                                          Container(
                                                                            width:
                                                                                310,
                                                                            height:
                                                                                1,
                                                                            margin:
                                                                                EdgeInsets.only(top: 24.0, bottom: 24.0),
                                                                            color:
                                                                                Color(0xFFD4DBED),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 22),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                                showModalBottomSheet(
                                                                                    context: context,
                                                                                    isScrollControlled: true,
                                                                                    builder: (context) => StatefulBuilder(
                                                                                          builder: (context, setState) {
                                                                                            return ConstrainedBox(
                                                                                                constraints: BoxConstraints(
                                                                                                  maxWidth: 350,
                                                                                                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                                                                                                ),
                                                                                                child: Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsets.only(top: 23.0, left: 16.0, right: 16.0),
                                                                                                    child: Align(
                                                                                                        alignment: Alignment.center,
                                                                                                        child: Column(
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              '删除电站',
                                                                                                              style: Theme.of(context).textTheme.headlineMedium,
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsets.only(top: 20.0),
                                                                                                              child: Align(
                                                                                                                alignment: Alignment.centerLeft,
                                                                                                                child: Text(
                                                                                                                  '信息安全验证',
                                                                                                                  style: Theme.of(context).textTheme.headlineSmall,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsets.only(top: 13.0),
                                                                                                              child: Align(
                                                                                                                alignment: Alignment.centerLeft,
                                                                                                                child: Text(
                                                                                                                  '请输入登录密码',
                                                                                                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Color(0xFF939393)),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsets.only(bottom: 60.0, top: 10.0),
                                                                                                              child: TextField(
                                                                                                                obscureText: isObscure,
                                                                                                                decoration: InputDecoration(
                                                                                                                    suffixIcon: IconButton(
                                                                                                                      icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Color(0xFF7989B2)),
                                                                                                                      onPressed: () {
                                                                                                                        setState(() {
                                                                                                                          isObscure = !isObscure;
                                                                                                                        });
                                                                                                                      },
                                                                                                                    ),
                                                                                                                    hintText: '请输入您的密码'),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Align(
                                                                                                              alignment: Alignment.centerRight,
                                                                                                              child: ElevatedButton(
                                                                                                                onPressed: () {
                                                                                                                  Navigator.pop(context);
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
                                                                                                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                                                                                                                ),
                                                                                                              ),
                                                                                                            )
                                                                                                          ],
                                                                                                        )),
                                                                                                  ),
                                                                                                ));
                                                                                          },
                                                                                        ));
                                                                              },
                                                                              child: Text(
                                                                                '删除',
                                                                                textAlign: TextAlign.center,
                                                                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Color(0xFFF5222D)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.centerRight,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.white,
                                                                                minimumSize: Size(80, 50),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                  side: BorderSide(color: Color(0xFF5475F7)),
                                                                                ),
                                                                              ),
                                                                              child: Text(
                                                                                '取消',
                                                                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Color(0xFF5475F7)),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 60,
                                                            height: 85,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/ic_plant_nocircle_more.svg'),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  width: 220,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .baseline,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 2.5,right: 2),
                                                            child: SvgPicture.asset(
                                                                width: 12,
                                                                height: 12,
                                                                'assets/ic_current_power.svg'),
                                                          ),
                                                          Text(
                                                            '当前功率',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall
                                                                ?.copyWith(
                                                                    color: Color(
                                                                        0xFF939393)),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .baseline,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          Text('0.00',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall),
                                                          Text(
                                                            'kW',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayLarge
                                                                ?.copyWith(
                                                                    color: Color(
                                                                        0xFF939393)),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  width: 220,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .baseline,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          Container(
                                                                margin:
                                                                EdgeInsets.only(
                                                                    top: 5,right: 3),
                                                            child: SvgPicture.asset(
                                                                width: 12,
                                                                height: 7.23,
                                                                'assets/ic_capacity.svg'),
                                                          ),
                                                          Text(
                                                            '装机容量',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall
                                                                ?.copyWith(
                                                                    color: Color(
                                                                        0xFF939393)),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .baseline,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          Text('0.00',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headlineSmall),
                                                          Text(
                                                            'kW',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayLarge
                                                                ?.copyWith(
                                                                    color: Color(
                                                                        0xFF939393)),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )));
                              }
                            ),
                          )),
                    ))
              ],
            ),
          )
        ],
      )
    ]);
  }
}
