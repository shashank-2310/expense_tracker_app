import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/date_picker.dart';
import 'package:expense_tracker_app/widgets/dropdown_button.dart';
import 'package:expense_tracker_app/widgets/input_controllers.dart';
import 'package:expense_tracker_app/widgets/modal_buttons.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  /*  Always dispose when using TextEditingController, 
      or else the input will live on in the memory forever 
  */

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    /* tryParse('hello') => null & tryParse('1.12') => 1.12 */

    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final bool titleIsInvalid = _titleController.text.trim().isEmpty;
    final bool dateIsInvalid = _selectedDate == null;

    if (titleIsInvalid || amountIsInvalid || dateIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }
  /*  Nothing needs to be done after this.
      This whole fxn is just for validating the 
      data & displaying the error message only.
  */

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  InputControllers(
                    amountController: _amountController,
                    titleController: _titleController,
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropDownBtn(selectedCategory: _selectedCategory,),
                      const SizedBox(width: 24),
                      DatePicker(
                        selectedDate: _selectedDate,
                        presentDatePicker: _presentDatePicker,
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      DatePicker(
                        selectedDate: _selectedDate,
                        presentDatePicker: _presentDatePicker,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  ModalBtns(submitExpenseData: _submitExpenseData)
                else
                  Row(
                    children: [
                      DropDownBtn(selectedCategory: _selectedCategory),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _submitExpenseData,
                        icon: const Icon(Icons.save_alt),
                        label: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
