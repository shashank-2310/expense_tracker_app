import 'package:flutter/material.dart';

class InputControllers extends StatefulWidget {
  const InputControllers({super.key, required this.amountController, required this.titleController});

  final TextEditingController titleController;
  final TextEditingController amountController;

  @override
  State<InputControllers> createState() => _InputControllersState();
}

class _InputControllersState extends State<InputControllers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: widget.titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: TextField(
            controller: widget.amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$ ',
              label: Text('Amount'),
            ),
          ),
        ),
      ],
    );
  }
}
