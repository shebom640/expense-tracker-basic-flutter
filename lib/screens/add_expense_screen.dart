import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _type = 'expense'; // Default transaction type is 'expense'

  // Save the transaction and return it to the previous screen
  _saveTransaction() {
    final description = _descriptionController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    // Only save if description is not empty and amount is greater than 0
    if (description.isNotEmpty && amount > 0) {
      final newTransaction = Expense(
        description: description,
        amount: amount,
        date: DateTime.now(),
        type: _type, // Transaction type (expense or income)
      );
      Navigator.pop(context, newTransaction); // Return the new transaction
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
            // TextField for the transaction description
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            // TextField for the transaction amount
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            // Dropdown to select 'income' or 'expense'
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
            // Button to save the transaction
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
