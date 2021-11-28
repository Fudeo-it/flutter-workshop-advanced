import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/repositories/database_repository.dart';

final storeModel = StoreModel().obs;

class StoreModel {
  List<ExpenseModel> expenses = [];

  Future<void> initialize() async {
    expenses = await GetIt.instance<DatabaseRepository>().allExpenses();
  }

  double get totalExpenseToday {
    final currentDate = DateTime.now();
    final firstDayOfMonth = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );

    return expenses.where((expenseModel) {
      return expenseModel.createdOn.isAfter(firstDayOfMonth);
    }).fold(0.0, (acc, expenseModel) {
      return acc + expenseModel.value;
    });
  }

  double get totalExpenseWeek {
    final currentDate = DateTime.now();
    final firstDayOfWeek = currentDate.subtract(Duration(
      days: currentDate.weekday,
    ));

    return expenses.where((expenseModel) {
      return expenseModel.createdOn.isAfter(firstDayOfWeek);
    }).fold(0.0, (acc, expenseModel) {
      return acc + expenseModel.value;
    });
  }

  double get totalExpenseMonth {
    final currentDate = DateTime.now();
    final firstDayOfMonth = DateTime(
      currentDate.year,
      currentDate.month,
      0,
    );

    return expenses.where((expenseModel) {
      return expenseModel.createdOn.isAfter(firstDayOfMonth);
    }).fold(0.0, (acc, expenseModel) {
      return acc + expenseModel.value;
    });
  }

  double get totalExpenseYear {
    final currentDate = DateTime.now();
    final firstDayOfYear = DateTime(
      currentDate.year,
      0,
      0,
    );

    return expenses.where((expenseModel) {
      return expenseModel.createdOn.isAfter(firstDayOfYear);
    }).fold(0.0, (acc, expenseModel) {
      return acc + expenseModel.value;
    });
  }

  void createExpense({required double value, required String? description}) {
    final expenseModel = ExpenseModel.create(
      value: value,
      description: description,
      createdOn: DateTime.now(),
    );

    expenses.insert(0, expenseModel);
    GetIt.instance<DatabaseRepository>().insertExpense(expenseModel);

    storeModel.refresh();
  }

  void editExpense(
    ExpenseModel expenseModel, {
    required double value,
    required String? description,
  }) {
    expenseModel.value = value;
    expenseModel.description = description;
    GetIt.instance<DatabaseRepository>().updateExpense(expenseModel);

    storeModel.refresh();
  }

  void deleteExpense(ExpenseModel expenseModel) {
    expenses.remove(expenseModel);
    GetIt.instance<DatabaseRepository>().deleteExpense(expenseModel);

    storeModel.refresh();
  }
}
