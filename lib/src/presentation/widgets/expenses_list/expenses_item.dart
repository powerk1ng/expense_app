import 'package:expense_app/src/data/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expenseItem});

  final Expense expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenseItem.title),
            const SizedBox(height: 4),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expenseItem.category],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(expenseItem.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
