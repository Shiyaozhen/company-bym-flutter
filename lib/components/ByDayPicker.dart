import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DayPicker extends StatefulWidget {
  final Function(DateTime) onConfirm;

  DayPicker({required this.onConfirm});

  @override
  _DayPickerState createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  late DateTime _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
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
            availableCalendarFormats: const {
              CalendarFormat.month: 'day',
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDay,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              if (_selectedDay != null) {
                widget.onConfirm(_selectedDay!);
              }
              Navigator.pop(context);
            },
            child: Text('Confirm'),
          ),
        )
      ],
    );
  }
}
