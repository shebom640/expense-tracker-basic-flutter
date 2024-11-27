# **Expense Tracker App**

## 📝 **Overview**

The **Expense Tracker** app helps you manage your daily finances by tracking your income and expenses. It allows you to add, view, and delete transactions while providing a clear overview of your current balance. The app supports both income and expense types and gives you the flexibility to manage your finances easily.

## 💡 **Features**

- **Track Transactions**: Add, view, and delete both income and expense transactions.
- **Balance Calculation**: Automatically calculates the balance by subtracting expenses from income.
- **Responsive UI**: Beautiful, clean, and user-friendly interface with a modern design.
- **Persistent Data**: All data is stored in a local SQLite database, ensuring persistence even after the app is closed.

## 📱 **Technologies Used**

- **Flutter**: For building the app's user interface.
- **SQLite**: For local database management to store transaction data.
- **Intl Package**: For date formatting to display transaction dates.

## 🛠 **How It Works**

1. **Main Screen**
   - The **Expense List Screen** displays all your transactions (both income and expenses) with details like description, amount, date, and type.
   - It also shows your current balance, which is calculated as `Income - Expenses`.
2. **Adding a Transaction**

   - Click the **Floating Action Button** (`+` icon) to add a new transaction.
   - Enter the description (e.g., salary, groceries), amount (numeric), and choose the type (`Income` or `Expense`).
   - The transaction is saved to the database, and the screen reloads to show the updated list.

3. **Deleting a Transaction**

   - Long press on any transaction to delete it.
   - The transaction will be removed from the database, and the list will update accordingly.

4. **Balance Calculation**
   - The balance is automatically updated based on your transactions. It is calculated as:
     ```
     Balance = Total Income - Total Expenses
     ```

## 💾 **Database Structure**

The app uses an SQLite database to persist transactions. The database includes a table `transactions` with the following columns:

- `id`: Unique identifier for the transaction.
- `description`: Description of the transaction.
- `amount`: Amount of money for the transaction.
- `date`: Date when the transaction was made.
- `type`: Type of transaction (`income` or `expense`).
