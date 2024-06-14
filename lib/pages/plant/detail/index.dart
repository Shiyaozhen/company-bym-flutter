import 'package:BYM/components/ByCircular.dart';
import 'package:BYM/get_pages.dart';
import 'package:BYM/pages/plant/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:BYM/utils/unit_converter.dart';

class PlantDetailOverview extends StatelessWidget {
  const PlantDetailOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD6DDFF),
        title: GetBuilder<PlantDetailController>(
          builder: (_) => Text(
            _.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
            icon: Icon(Icons.add_circle_outline),
            color: Color(0xFF383838),
            onPressed: () {
              // Handle the button press
            },
          ),
        ],
      ),
      body: GetBuilder<PlantDetailController>(
        builder: (_) => Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1.2],
              colors: [
                Color(0xFFD6DDFF),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Column(
            children: [
              // 房屋图片
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/ic_plant_gif.png'),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          convertPower(_.power),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 8, 8, 8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'kW',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF939393),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              // 2
              Row(
                children: [
                  // 发电量
                  Expanded(
                    child: Column(
                      children: [
                        // 日
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFFFFFFF),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                width: 28,
                                height: 28,
                                'assets/ic_plant_energy_day.svg',
                              ),
                              const SizedBox(width: 12,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '日发电量',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                        color: Color(0xFF939393)),
                                  ),
                                  const SizedBox(height: 6,),
                                  Text(
                                    convertEnergy(_.energyDay),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12,),
                        // 月
                        Container(
                          height: 80,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFFFFFFF),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                width: 28,
                                height: 28,
                                'assets/ic_plant_energy_day.svg',
                              ),
                              const SizedBox(width: 12,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '月发电量',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                        color: Color(0xFF939393)),
                                  ),
                                  const SizedBox(height: 6,),
                                  Text(
                                    convertEnergy(_.energyMonth),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12,),
                  // 功率比
                  Expanded(
                    child: Container(
                      height: 172,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '功率比',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Color(0xFF939393),
                                ),
                          ),
                          GradientCircularProgressIndicator(
                            radius: 40.0,
                            lineWidth: 4.0,
                            percent: 0.1,
                            colors: const [
                              Color(0xFF5475F8),
                              Color(0xFF5475F8),
                            ],
                          ),
                          Text(
                            '装机容量: ${convertEnergy(_.capacity)}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Color(0xFF939393)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // 3
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () => {
                    BYRoute.toNamed('/TotalEnergy',
                        arguments: {'stationName': ''})
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                              width: 20.0,
                              height: 20.0,
                              'assets/ic_plant_energy_total.svg'),
                          const SizedBox(width: 10),
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
                            convertEnergy(_.energyAll),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(width: 5,),
                          const Icon(Icons.navigate_next),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

