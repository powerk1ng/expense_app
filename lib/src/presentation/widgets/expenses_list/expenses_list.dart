import 'package:expense_app/src/data/models/expense.dart';
import 'package:expense_app/src/presentation/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onExpenseRemove});

  final List<Expense> expenses;
  final void Function(Expense expense, int index) onExpenseRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(expenses[index]),
              onDismissed: (direction) =>
                  onExpenseRemove(expenses[index], index),
              child: ExpensesItem(
                expenseItem: expenses[index],
              ),
            ));
  }
}
