import 'package:BYM/components/ByDayPicker.dart';
import 'package:BYM/components/ByMonthPicker.dart';
import 'package:BYM/components/ByWeekPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalEnergy extends StatefulWidget {
  const TotalEnergy({Key? key}) : super(key: key);

  @override
  _TotalEnergyState createState() => _TotalEnergyState();
}

class _TotalEnergyState extends State<TotalEnergy> {
  int currentSegment = 0;
  //修改日
  void changeDay() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.64,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DayPicker(
                      onConfirm: (startDay) {
                        print('Selected Week: $startDay');
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  //修改周
  void changeWeek() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.34,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: WeekPicker(
                      onConfirm: (startOfWeek, endOfWeek) {
                        print('Selected Week: $startOfWeek - $endOfWeek');
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  //修改月
  void changeMonth() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.64,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: MonthPicker(
                    onConfirm: (startOfMonth, endOfMonth) {
                      print('Selected Week: $startOfMonth - $endOfMonth');
                    },
                  ))
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //日
    DateTime now = DateTime.now();
    String formattedDateDay = "${now.year}.${now.month}.${now.day}";
    //月
    String formattedDateMonth = "${now.year}.${now.month}";
    //周
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday));
    DateTime endOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday - 1));
    String formattedDateSWeek =
        "${startOfWeek.year}.${startOfWeek.month}.${startOfWeek.day}";
    String formattedDateEWeek =
        "${endOfWeek.year}.${endOfWeek.month}.${endOfWeek.day}";
    final Map<String, dynamic> arguments = Get.arguments;
    final String stationName = arguments['stationName'];
    Map<int, Widget> segments = {0: Text('日'), 1: Text('周'), 2: Text('月')};
    print(stationName);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          stationName,
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
        padding: EdgeInsets.only(left: 13, right: 13),
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double segmentedButtonWidth = constraints.maxWidth * 0.9;
                  return Container(
                    width: segmentedButtonWidth,
                    height: 50,
                    child: Transform.scale(
                      scale: 1.2,
                      child: CupertinoSegmentedControl(
                        children: segments,
                        onValueChanged: (value) {
                          setState(() {
                            currentSegment = value;
                            print(currentSegment);
                          });
                        },
                        groupValue: currentSegment,
                        unselectedColor: Color(0xFFF5F7FF),
                        selectedColor: Color(0xFF5475F7),
                        borderColor: Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Visibility(
              visible: currentSegment == 0,
              child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 10.0),
                  child: InkWell(
                    onTap: changeDay,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDateDay,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF939393)),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 24,
                          color: Color(0xFF939393),
                        ),
                      ],
                    ),
                  )),
            ),
            Visibility(
              visible: currentSegment == 1,
              child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 10.0),
                  child: InkWell(
                    onTap: changeWeek,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDateSWeek,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF939393)),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 24,
                          color: Color(0xFF939393),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3.0, right: 8.0),
                          color: Color(0xFF939393), // 背景色
                          child: SizedBox(
                            width: 20,
                            height: 1.6,
                          ),
                        ),
                        Text(
                          formattedDateEWeek,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF939393)),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 24,
                          color: Color(0xFF939393),
                        ),
                      ],
                    ),
                  )),
            ),
            Visibility(
              visible: currentSegment == 2,
              child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 10.0),
                  child: InkWell(
                    onTap: changeMonth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDateMonth,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(color: Color(0xFF939393)),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 24,
                          color: Color(0xFF939393),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 52.0,
            ),
             Visibility(
              visible: currentSegment == 0,
              child:  Container(
              width: 220,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '000.00',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 36.0),
                      ),
                      Text(
                        'kWh',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 32.0),
                      )
                    ],
                  ),
                  Text(
                    '日发电量',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 18.0,color: Color(0xFF7989B2)),
                  ),
                  SizedBox(height: 5,)
                ],
              ),
            )),
             Visibility(
              visible: currentSegment == 1,
              child:  Container(
              width: 220,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '000.00',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 36.0),
                      ),
                      Text(
                        'kWh',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 32.0),
                      )
                    ],
                  ),
                  Text(
                    '周发电量',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 18.0,color: Color(0xFF7989B2)),
                  ),
                  SizedBox(height: 5,)
                ],
              ),
            )),
             Visibility(
              visible: currentSegment == 2,
              child:  Container(
              width: 220,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '000.00',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 36.0),
                      ),
                      Text(
                        'kWh',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: 32.0),
                      )
                    ],
                  ),
                  Text(
                    '月发电量',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 18.0,color: Color(0xFF7989B2)),
                  ),
                  SizedBox(height: 5,)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
