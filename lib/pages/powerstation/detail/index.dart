import 'package:BYM/components/ByCircular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailIndex extends StatefulWidget {
  const DetailIndex({Key? key, required Map<String, dynamic> arguments})
      : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<DetailIndex> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String stationName = arguments['stationName'];
    print(stationName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD6DDFF),
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Color(0xFF383838),
            onPressed: () {
              // Handle the button press
            },
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1.2],
              colors: [
                const Color(0xFFD6DDFF),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/ic_plant_gif.png'),
                ),
                // Positioned(
                //   top: 100, // 指定文字位置的纵坐标
                //   left: 50, // 指定文字位置的横坐标
                //   child: Text(
                //     'Hello, World!',
                //     style: TextStyle(
                //       fontSize: 24,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(top: 14, left: 15),
                      child: Column(
                        children: [
                          Text(
                            '0.00',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 8, 8, 8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'kW',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF939393),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 36, left: 14.0, right: 14.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        width: 170,
                        height: 80,
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                                width: 28,
                                height: 28,
                                'assets/ic_plant_energy_day.svg'),
                            Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 90,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '日发电量',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.copyWith(
                                                color: Color(0xFF939393)),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '00.00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      Text(
                                        'kWh',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 80,
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                                width: 28,
                                height: 28,
                                'assets/ic_plant_energy_month.svg'),
                            Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 90,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '月发电量',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge
                                            ?.copyWith(
                                                color: Color(0xFF939393)),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '00.00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      Text(
                                        'kWh',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 11.0, left: 14.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '功率比',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(color: Color(0xFF939393)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GradientCircularProgressIndicator(
                              radius: 50.0,
                              lineWidth: 8.0,
                              percent: 0.99,
                              colors: [Color(0xFF5475F8), Color(0xFF5475F8)],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Baseline(
                                  baselineType: TextBaseline.alphabetic,
                                  baseline: 20,
                                  child: Text(
                                    '装机容量:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Color(0xFF939393)),
                                  ),
                                ),
                                Baseline(
                                  baselineType: TextBaseline.alphabetic,
                                  baseline: 20,
                                  child: Text(
                                    '00.00',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(color: Color(0xFF939393)),
                                  ),
                                ),
                                Baseline(
                                  baselineType: TextBaseline.alphabetic,
                                  baseline: 20,
                                  child: Text(
                                    'kW',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: Color(0xFF939393)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                          width: 20.0,
                          height: 20.0,
                          'assets/ic_plant_energy_total.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '累计发电量',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: Color(0xFF939393)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '00.00',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'kWh',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
