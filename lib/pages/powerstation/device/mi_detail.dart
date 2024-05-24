import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MIDetail extends StatefulWidget {
  const MIDetail({super.key, required this.arguments});

  final Map<String, dynamic> arguments;
  @override
  State<MIDetail> createState() => _MIDetailState();
}

class _MIDetailState extends State<MIDetail> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String MIId = arguments['MIId'];
    print(MIId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F7FF),
          title: Column(
            children: [
              Text(
                MIId,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          centerTitle: true,
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFF383838),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xFFF5F7FF)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, right: 13, left: 13),
              child: Column(
                children: [
                  MIModelWidget(),
                  SizedBox(
                    height: 25.0,
                  ),
                  EnergyWidget()
                ],
              ),
            )
          ],
        ));
  }
}

//微型逆变器
class MIModelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(color: Colors.blue),
      ),
    );
  }
}

//日、月发电量

class EnergyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Expanded(
            child: Container(
          height: 80.0,
        )),
        SizedBox(
          width: 10.0,
        ),
        Expanded(child: Container())
      ],
    ));
  }
}
