import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _type = 'expense'; // Default to 'expense'

  _saveTransaction() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (description.isNotEmpty && amount > 0) {
      final newTransaction = Expense(
        description: description,
        amount: amount,
        date: DateTime.now(),
        type: _type, // Include type (income or expense)
      );
      Navigator.pop(context, newTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            DropdownButton<String>(
              value: _type,
              items: [
                DropdownMenuItem(value: 'expense', child: Text('Expense')),
                DropdownMenuItem(value: 'income', child: Text('Income')),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTransaction,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
