import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_helper.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  List<Expense> _transactions = [];
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Load all transactions and balance
  _loadTransactions() async {
    var transactions =
        await DatabaseHelper.instance.getTransactionsByType('expense');
    var incomeTransactions =
        await DatabaseHelper.instance.getTransactionsByType('income');
    var balance = await DatabaseHelper.instance.getBalance();

    setState(() {
      _transactions = [...transactions, ...incomeTransactions];
      _balance = balance;
    });
  }

  // Navigate to add new transaction
  _navigateToAddTransaction() async {
    final newTransaction = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpenseScreen()),
    );
    if (newTransaction != null) {
      await DatabaseHelper.instance.insertTransaction(newTransaction);
      _loadTransactions();
    }
  }

  // Delete a transaction by id
  _deleteTransaction(int id) async {
    await DatabaseHelper.instance.deleteTransaction(id);
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: Colors.blueGrey[800],
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Balance: ₹$_balance',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                String sign = transaction.type == 'expense' ? '-' : '+';
                double amount = transaction.amount;
                Color amountColor =
                    transaction.type == 'expense' ? Colors.red : Colors.green;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Icon(
                      transaction.type == 'expense'
                          ? Icons.remove_circle_outline
                          : Icons.add_circle_outline,
                      color: amountColor,
                    ),
                    title: Text(
                      transaction.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction.date),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Text(
                      '$sign₹${amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: amountColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onLongPress: () => _deleteTransaction(transaction.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTransaction,
        backgroundColor: Colors.blueGrey[800],
        child: Icon(Icons.add),
      ),
    );
  }
}
