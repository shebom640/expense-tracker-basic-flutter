import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DatabaseHelper {
  static const _databaseName = "expense_tracker.db";
  static const _databaseVersion = 2;

  static const table = 'transactions';
  static const columnId = 'id';
  static const columnDescription = 'description';
  static const columnAmount = 'amount';
  static const columnDate = 'date';
  static const columnType = 'type'; // 'income' or 'expense'

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  // Lazy initialization of the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database and create the table
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    // Open the database and create the table if not exists
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      print("Creating database and transactions table...");
      await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnDescription TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnType TEXT NOT NULL CHECK($columnType IN ('income', 'expense'))
      )
    ''');
      print("Table $table created successfully.");
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      print("Upgrading database from version $oldVersion to $newVersion...");
      // Handle schema migrations if needed
    });
  }

  // Insert a new transaction (income or expense)
  Future<int> insertTransaction(Expense expense) async {
    Database db = await database;
    try {
      return await db.insert(table, expense.toMap());
    } catch (e) {
      print("Error inserting transaction: $e");
      return -1; // Indicate failure
    }
  }

  // Get all transactions of a specific type (income or expense)
  Future<List<Expense>> getTransactionsByType(String type) async {
    Database db = await database;
    var result =
        await db.query(table, where: '$columnType = ?', whereArgs: [type]);
    return result.isNotEmpty
        ? result.map((e) => Expense.fromMap(e)).toList()
        : [];
  }

  // Get the total balance (Income - Expense)
  Future<double> getBalance() async {
    Database db = await database;
    try {
      var incomeResult = await db.rawQuery(
          'SELECT SUM($columnAmount) FROM $table WHERE $columnType = "income"');
      var expenseResult = await db.rawQuery(
          'SELECT SUM($columnAmount) FROM $table WHERE $columnType = "expense"');

      double income = incomeResult.isNotEmpty &&
              incomeResult[0]['SUM($columnAmount)'] != null
          ? (incomeResult[0]['SUM($columnAmount)'] as double)
          : 0.0;

      double expense = expenseResult.isNotEmpty &&
              expenseResult[0]['SUM($columnAmount)'] != null
          ? (expenseResult[0]['SUM($columnAmount)'] as double)
          : 0.0;

      return income - expense;
    } catch (e) {
      print("Error calculating balance: $e");
      return 0.0; // Indicate failure
    }
  }

  // Delete a transaction by id
  Future<int> deleteTransaction(int id) async {
    Database db = await database;
    try {
      return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    } catch (e) {
      print("Error deleting transaction: $e");
      return -1; // Indicate failure
    }
  }
}
