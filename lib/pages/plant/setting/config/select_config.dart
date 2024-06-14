import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';

class SelectConfig extends StatefulWidget {
  const SelectConfig({super.key});

  @override
  State<SelectConfig> createState() => _SelectConfigState();
}

class _SelectConfigState extends State<SelectConfig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设备配网',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
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
      ),
      body: Container(
        padding: EdgeInsets.only(left: 13.0, right: 13.0),
        child: Column(
          children: [
            SizedBox(
              height: 18.0,
            ),
            BlueConfigState(),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            ApConfigState()
          ],
        ),
      ),
    );
  }
}

//蓝牙配网
class BlueConfigState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Color(0xFFF5F7FF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: () => {BYRoute.toNamed('/ConfigNet')},
          child: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.bluetooth,
                  size: 28,
                ),
                color: Color(0xFF5475F7),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '蓝牙配网',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
        ));
  }
}

//AP热点配网
class ApConfigState extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Color(0xFFF5F7FF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: () => {BYRoute.toNamed('/ApSearchDevice')},
          child: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.wifi,
                  size: 28,
                ),
                color: Color(0xFF5475F7),
                onPressed: () {},
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '热点配网',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
        ));
  }
}
