import 'package:flutter/material.dart';

class APInfo extends StatelessWidget {
  const APInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('EMU 90000051'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F7FF),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('基本信息'),
            APInfoItem(label: '类型', value: 'EMU'),
            APInfoItem(label: '信号强度', value: '-100'),
            APInfoItem(label: '运行模式', value: 'PLCC透传模式'),
            APInfoItem(label: '功能码', value: '00'),
            APInfoItem(label: '当前功率', value: '0 KW'),
            APInfoItem(label: '当日发电量', value: '0 kWh'),
            APInfoItem(label: '更新时间', value: '2024-6-7'),
          ],
        ),
      ),
    );
  }
}

class APInfoItem extends StatelessWidget {
  const APInfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(value),
            ],
          ),
        ),
        const Divider(height: 20, thickness: 1, color: Color(0xFFF5F7FF),),
      ],
    );
  }
}
