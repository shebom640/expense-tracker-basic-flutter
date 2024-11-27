import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/expense_list_screen.dart';
import 'package:path/path.dart';
import 'db/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter bindings

  // Get the path for the database
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "expense_tracker.db");

  // Delete the existing database (for testing purposes)
  await deleteDatabase(path);

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
