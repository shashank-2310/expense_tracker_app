import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownBtn extends StatefulWidget {
  DropDownBtn({super.key, required this.selectedCategory});

  Category selectedCategory;

  @override
  State<DropDownBtn> createState() => _DropDownBtnState();
}

class _DropDownBtnState extends State<DropDownBtn> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          widget.selectedCategory = value;
        });
      },
    );
  }
}
