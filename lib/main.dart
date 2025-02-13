import 'package:expense_app/src/data/models/expense.dart';
import 'package:expense_app/src/presentation/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Expense> _expensesList = [
    Expense(
      amount: 100,
      title: 'Sega courses',
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      amount: 200,
      title: 'Pizza',
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      amount: 150,
      title: 'Work',
      date: DateTime.now(),
      category: Category.work,
    )
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: _scaffoldKey.currentContext!,
      isScrollControlled: true,
      builder: (ctx) {
        return SizedBox(
            height: MediaQuery.of(ctx).size.height * 0.8,
            width: double.infinity,
            child: const Text('Modal bottom sheet'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Add expense'),
          actions: [
            IconButton(
              tooltip: 'Show Modal',
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: ExpensesList(
          expenses: _expensesList,
        ),
      ),
    );
  }
}
