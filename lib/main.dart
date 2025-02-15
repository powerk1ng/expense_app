import 'package:expense_app/src/data/models/expense.dart';
import 'package:expense_app/src/presentation/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/src/presentation/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Expense> _expensesList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: _scaffoldKey.currentContext!,
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

    //clear previous messages if they exist
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).clearSnackBars();

    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(
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
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        textAlign: TextAlign.center,
        'No expenses found, \nstart adding now!',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      ),
    );

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onExpenseRemove: _removeExpense,
      );
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
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
            body: mainContent));
  }
}
