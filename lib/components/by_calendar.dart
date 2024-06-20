import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// 日选择器
class ByPickerDay extends StatefulWidget {
  final Function(DateTime) callback;

  const ByPickerDay({
    super.key,
    required this.callback,
  });

  @override
  State<ByPickerDay> createState() => _ByPickerDayState();
}

class _ByPickerDayState extends State<ByPickerDay> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择月份'),
      content: SizedBox(
        width: 600,
        height: 400,
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}

// 月选择器
class ByPickerMonth extends StatefulWidget {
  final String year;
  final String month;
  final void Function(String year, String month) callback;

  const ByPickerMonth({
    super.key,
    required this.year,
    required this.month,
    required this.callback,
  });

  @override
  State<ByPickerMonth> createState() => _ByPickerMonthState();
}

class _ByPickerMonthState extends State<ByPickerMonth> {
  final FixedExtentScrollController _yearController = FixedExtentScrollController();
  final FixedExtentScrollController _monthController = FixedExtentScrollController();

  final List _yearList = [
    for(int i = DateTime.now().year - 3; i < DateTime.now().year + 1; i++) i.toString()
  ];
  final List _monthList = [
    for(int i = 1; i < 13; i++) '$i'.padLeft(2, '0')
  ];

  int _yearIndex = 0;
  int _monthIndex = 0;

  void playAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));

    _yearController.animateToItem(
      _yearList.indexOf(widget.year),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );

    _monthController.animateToItem(
      _monthList.indexOf(widget.month.padLeft(2, '0')),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    playAnimation();

    _yearIndex = _yearList.indexOf(widget.year);
    _monthIndex = _monthList.indexOf(widget.month.padLeft(2, '0'));
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择月份'),
      content: SizedBox(
        height: 200,
        child: Row(
          children: [
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: _yearController,
                itemExtent: 40.0,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (int index) {
                  _yearIndex = index;
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: _yearList.length,
                  builder: (BuildContext context, int index) {
                    if (index < 0 || index >= _yearList.length) {
                      return null;
                    }
                    return Center(
                      child: Text('${_yearList[index]}'),
                    );
                  },
                ),
                magnification: 1.5,
                overAndUnderCenterOpacity: 0.3,
              ),
            ),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: _monthController,
                itemExtent: 40.0,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (int index) {
                  _monthIndex = index;
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: _monthList.length,
                  builder: (BuildContext context, int index) {
                    if (index < 0 || index >= _monthList.length) {
                      return null;
                    }
                    return Center(
                      child: Text('${_monthList[index]}'),
                    );
                  },
                ),
                magnification: 1.5,
                overAndUnderCenterOpacity: 0.3,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.callback(
              _yearList[_yearIndex].toString(),
              _monthList[_monthIndex],
            );
            Navigator.pop(context);
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}

// 年选择器
class ByPickerYear extends StatefulWidget {
  final String year;
  final void Function(String year) callback;

  const ByPickerYear({
    super.key,
    required this.year,
    required this.callback,
  });

  @override
  State<ByPickerYear> createState() => _ByPickerYearState();
}

class _ByPickerYearState extends State<ByPickerYear> {
  final FixedExtentScrollController _yearController = FixedExtentScrollController();

  final List _yearList = [
    for(int i = DateTime.now().year - 3; i < DateTime.now().year + 1; i++) i.toString()
  ];

  int _yearIndex = 0;

  void playAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));

    _yearController.animateToItem(
      _yearList.indexOf(widget.year),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    playAnimation();

    _yearIndex = _yearList.indexOf(widget.year);
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择月份'),
      content: SizedBox(
        height: 200,
        child: Row(
          children: [
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: _yearController,
                itemExtent: 40.0,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (int index) {
                  _yearIndex = index;
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: _yearList.length,
                  builder: (BuildContext context, int index) {
                    if (index < 0 || index >= _yearList.length) {
                      return null;
                    }
                    return Center(
                      child: Text('${_yearList[index]}'),
                    );
                  },
                ),
                magnification: 1.5,
                overAndUnderCenterOpacity: 0.3,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.callback(
              _yearList[_yearIndex].toString(),
            );
            Navigator.pop(context);
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}

