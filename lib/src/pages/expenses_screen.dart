import 'package:expense_app/src/models/expense.dart';
import 'package:expense_app/src/presentation/widgets/expenses_list.dart';
import 'package:expense_app/src/presentation/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expensesList = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewExpense(_addExpense);
      },
    );
  }

  Future<void> _addExpense(Expense expense) async {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense, int index) {
    setState(() {
      _expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        duration: const Duration(seconds: 5),
        content: const Text('Removed Successfully!'),
        action: SnackBarAction(
            label: 'Undo',
            backgroundColor: Colors.amber,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                _expensesList.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        textAlign: TextAlign.center,
        'No expenses found, \nstart adding now!',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onExpenseRemove: _removeExpense,
      );
    }

    return Scaffold(
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
      body: mainContent,
    );
  }
}
