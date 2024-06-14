import 'package:BYM/pages/plant/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/get_pages.dart';

class PlantMore extends StatelessWidget {
  const PlantMore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD6DDFF),
          title: Text(
            _.name,
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
        body: Container(
          padding: const EdgeInsets.only(left: 13.0, right: 13.0),
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
              const SizedBox(height: 18.0),
              SetNetWidget(),
              const SizedBox(height: 18.0),
              PlantInfo(),
              const SizedBox(height: 18.0),
              const AntiBackFlow(),
            ],
          ),
        ),
      ),
    );
  }
}

//设备配网
class SetNetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {BYRoute.toNamed('/SelectConfig')},
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.only(top: 15.0, bottom: 20.0, left: 12.0, right: 12.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.wifi,
                  size: 20,
                  color: Color(0xFF7989B2),
                ),
                const SizedBox(width: 20.0),
                Text(
                  '设备配网',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFF7989B2),
            ),
          ],
        ),
      ),
    );
  }
}

//电站信息
class PlantInfo extends StatelessWidget {
  const PlantInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BYRoute.toNamed('/ChangeInfo');
      },
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.format_align_center,
                  size: 20,
                  color: Color(0xFF7989B2),
                ),
                const SizedBox(width: 20.0),
                Text(
                  '电站信息',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFF7989B2),
            ),
          ],
        ),
      ),
    );
  }
}

// 防逆流
class AntiBackFlow extends StatelessWidget {
  const AntiBackFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlantDetailController>(builder: (_) => Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.switch_access_shortcut_add_rounded,
                size: 20,
                color: Color(0xFF7989B2),
              ),
              const SizedBox(width: 20.0),
              Text(
                '防逆流开关',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Switch(
            value: _.isEnable,
            activeColor: const Color(0xFF5475F7),
            onChanged: (value) {
              _.switchAntiBackFlow(value);
            },
          ),
        ],
      ),
    ));
  }
}

