class Expense {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String type; // 'income' or 'expense'

  Expense({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  // Convert Expense to a Map object for SQL storage
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type, // Include the type in the map
    };
  }

  // Convert Map object to Expense
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'], // Retrieve the id from the map (nullable)
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      type: map['type'], // Retrieve the type from map
    );
  }
}
