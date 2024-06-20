import 'package:flutter/material.dart';

class MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate;

  MonthPickerDialog({required this.initialDate});

  @override
  State<MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Month'),
      content: Container(
        width: double.maxFinite,
        height: 300.0,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          selectedDate: selectedDate,
          onChanged: (DateTime dateTime) {
            setState(() {
              selectedDate = dateTime;
            });
            Navigator.pop(context, selectedDate);
          },
        ),
      ),
    );
  }
}


class ByPickerYear extends StatefulWidget {
  final DateTime initialDate;
  final Function(int year) callback;

  const ByPickerYear({super.key, required this.initialDate, required this.callback});

  @override
  State<ByPickerYear> createState() => _ByPickerYearState();
}

class _ByPickerYearState extends State<ByPickerYear> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Year'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300.0,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 3),
          lastDate: DateTime(DateTime.now().year + 3),
          selectedDate: selectedDate,
          onChanged: (DateTime dateTime) {
            setState(() {
              selectedDate = dateTime;
            });
            widget.callback(dateTime.year);
            Navigator.pop(context, selectedDate);
          },
        ),
      ),
    );
  }
}

void showByPickerYear(BuildContext context, Function callback) {

}

