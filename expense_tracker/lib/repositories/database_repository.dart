import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'package:expense_tracker/models/expense_model.dart';

class DatabaseRepository {
  final Database database;
  DatabaseRepository(this.database);

  static Future<DatabaseRepository> newConnection() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = path.join(databasesPath, "expense_tracker.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          """
          CREATE TABLE expenses(
            uuid TEXT PRIMARY KEY,
            value REAL NOT NULL,
            description TEXT,
            createdOn INTEGER NOT NULL
          )
        """,
        );
      },
    );

    return DatabaseRepository(database);
  }

  Future<List<ExpenseModel>> allExpenses() async {
    final rows = await database.query("expenses");
    return rows.map((row) => ExpenseModel.fromMap(row)).toList();
  }

  Future<void> insertExpense(ExpenseModel expenseModel) async {
    await database.insert("expenses", expenseModel.toMap());
  }

  Future<void> updateExpense(ExpenseModel expenseModel) async {
    await database.update(
      "expenses",
      expenseModel.toMap(),
      where: "uuid = ?",
      whereArgs: [expenseModel.uuid],
    );
  }

  Future<void> deleteExpense(ExpenseModel expenseModel) async {
    await database.delete(
      "expenses",
      where: "uuid = ?",
      whereArgs: [expenseModel.uuid],
    );
  }
}
