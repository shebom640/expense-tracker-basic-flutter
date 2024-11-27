import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/expense_list_screen.dart';
import 'package:path/path.dart'; // Add this import
import 'db/database_helper.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // This line ensures Flutter bindings are initialized

  // Now you can access platform services, such as the database path
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "expense_tracker.db");

  // Delete the existing database for testing
  await deleteDatabase(path); // Deletes the current database if it exists

  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExpenseListScreen(),
    );
  }
}
