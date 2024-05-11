import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthPicker extends StatefulWidget {
  final void Function(DateTime start, DateTime end) onConfirm;

  const MonthPicker({required this.onConfirm});
  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late DateTime _selectedMonth;
  late DateTime _startOfMonth;
  late DateTime _endOfMonth;
  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now();
    _updateRange();
  }

  void _updateRange() {
    if (_selectedMonth != null) {
      _startOfMonth = DateTime(_selectedMonth!.year, _selectedMonth!.month);
      _endOfMonth =
          DateTime(_selectedMonth!.year, _selectedMonth!.month + 1, 0);
    }
  }

  void _printRange() {
    if (_startOfMonth != null && _endOfMonth != null) {
      print('Start of Month: ${_startOfMonth!.toString()}');
      print('End of Month: ${_endOfMonth!.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: TableCalendar(
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) {
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFFD6DDFF), // 设置选中日期的背景色为蓝色
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                    ),
                  ),
                );
              },
              defaultBuilder: (context, date, events) {
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 设置未选中日期的背景色为透明
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                    ),
                  ),
                );
              },
              outsideBuilder: (context, date, events) {
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 设置灰色日期的背景色为透明
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: Colors.grey, // 设置灰色日期的文本颜色为灰色
                      ),
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, events) {
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFF5475F8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // 设置当前日期的文本加粗
                      ),
                    ),
                  ),
                );
              },
            ),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameMonth(_selectedMonth, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedMonth = selectedDay!;
                _updateRange();
              });
            },
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedMonth,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              widget.onConfirm(_startOfMonth!, _endOfMonth!);
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        )
      ],
    );
  }
}

bool isSameMonth(DateTime? month1, DateTime month2) {
  if (month1 == null) return false;
  return month1.year == month2.year && month1.month == month2.month;
}
