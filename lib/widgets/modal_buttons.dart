import 'package:flutter/material.dart';

class ModalBtns extends StatefulWidget {
  const ModalBtns({super.key, required this.submitExpenseData});

  final void Function() submitExpenseData;

  @override
  State<ModalBtns> createState() => _ModalBtnsState();
}

class _ModalBtnsState extends State<ModalBtns> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          label: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: widget.submitExpenseData,
          icon: const Icon(Icons.save_alt),
          label: const Text('Save Expense'),
        ),
      ],
    );
  }
}
