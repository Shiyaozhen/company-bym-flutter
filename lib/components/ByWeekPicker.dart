import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekPicker extends StatefulWidget {
  final Function(DateTime, DateTime) onConfirm;
  WeekPicker({required this.onConfirm});

  @override
  _WeekPickerState createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  late DateTime _selectedWeek;
  late DateTime _startOfWeek;
  late DateTime _endOfWeek;

  @override
  void initState() {
    super.initState();
    _selectedWeek = DateTime.now();
    _calculateWeekRange();
  }

  void _calculateWeekRange() {
    _startOfWeek = _selectedWeek.subtract(Duration(days: _selectedWeek.weekday % 7));
    _endOfWeek = _startOfWeek.add(Duration(days: DateTime.daysPerWeek - 1));
  }

  bool isSameWeek(DateTime selectedWeek, DateTime date) {
    DateTime startOfWeek = selectedWeek.subtract(Duration(days: selectedWeek.weekday % 7));
    DateTime endOfWeek = startOfWeek.add(Duration(days: DateTime.daysPerWeek - 1));

    return date.isAfter(startOfWeek.subtract(Duration(days: 1))) && date.isBefore(endOfWeek.add(Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, date, events) {
              return Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Color(0xFFD6DDFF),
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
                  color: Colors.transparent,
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
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: Colors.grey,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
          },
          selectedDayPredicate: (day) => isSameWeek(_selectedWeek, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedWeek = selectedDay;
              _calculateWeekRange();
            });
          },
          firstDay: DateTime.utc(2010, 10, 17),
          lastDay: DateTime.utc(2030, 3, 13),
          focusedDay: _selectedWeek,
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              widget.onConfirm(_startOfWeek, _endOfWeek);
              Navigator.pop(context);
            },
            child: Text('Confirm'),
          ),
        )
      ],
    );
  }
}
