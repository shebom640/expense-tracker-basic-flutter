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

  // Convert Expense object to a Map for SQL storage
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type, // Include transaction type (income or expense)
    };
  }

  // Convert Map to Expense object
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'], // Nullable id
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      type: map['type'], // Transaction type
    );
  }
}
