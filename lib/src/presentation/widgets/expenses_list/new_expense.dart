import 'package:expense_app/src/data/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final Future<void> Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _addNewExpense() async {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure all fields are filled'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        ),
      );
    } else {
      await widget.onAddExpense(
        Expense(
            amount: enteredAmount,
            title: _titleController.text.trim(),
            date: _selectedDate!,
            category: _selectedCategory!),
      );

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDateSelected = _selectedDate != null;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
                labelStyle: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    maxLength: 20,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      label: Text('Amount'),
                      labelStyle: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(isDateSelected
                          ? formatter.format(_selectedDate!)
                          : 'Select date'),
                      IconButton(
                        iconSize: 24,
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(minHeight: 0, minWidth: 0),
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _addNewExpense,
                  child: Text('Save Changes'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
