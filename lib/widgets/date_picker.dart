import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.selectedDate,
    required this.presentDatePicker,
  });

  final DateTime? selectedDate;
  final void Function() presentDatePicker;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.selectedDate == null
                ? 'No date selected'
                : formatter.format(widget.selectedDate!),
          ),
          IconButton(
            onPressed: widget.presentDatePicker,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
