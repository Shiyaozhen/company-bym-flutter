import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  const Setting({super.key, required Map arguments});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String stationName = arguments['stationName'];
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
      ),
      body: Stack(
        children: [
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
          Container(
            padding: EdgeInsets.only(left: 13.0, right: 13.0),
            height: 280.0,
            child: Column(
              children: [
                SizedBox(
                  height: 18.0,
                ),
                SetNetWidget(),
                SizedBox(
                  height: 18.0,
                ),
                PowerInfoWidget(),
                SizedBox(
                  height: 18.0,
                ),
                SwitchWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}

//设备配网
class SetNetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {print('1')},
      child: Container(
        height: 70.0,
        padding:
            EdgeInsets.only(top: 15.0, bottom: 20.0, left: 12.0, right: 12.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.wifi,
                      size: 20,
                    ),
                    color: const Color(0xFF7989B2),
                    onPressed: () {},
                  ),
                  SizedBox(width: 20.0),
                  Baseline(
                    baseline: 24,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      '设备配网',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                color: const Color(0xFF7989B2),
                onPressed: () {
                  BYRoute.toNamed('/SelectConfig');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//电站信息
class PowerInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.format_align_center,
                    size: 20,
                  ),
                  color: const Color(0xFF7989B2),
                  onPressed: () {},
                ),
                SizedBox(width: 20.0),
                Baseline(
                  baseline: 24,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '电站信息',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              color: const Color(0xFF7989B2),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

//其他信息
class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State {
  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.switch_access_shortcut_add_rounded,
                  size: 20,
                ),
                color: const Color(0xFF7989B2),
                onPressed: () {},
              ),
              SizedBox(width: 20.0),
              Baseline(
                baseline: 24,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  '防逆流开关',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          Switch(
            value: _switch,
            activeColor: Color(0xFF5475F7),
            onChanged: (value) {
              setState(() {
                _switch = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
