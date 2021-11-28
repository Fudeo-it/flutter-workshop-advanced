import 'package:expense_tracker/components/expense_edit.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/store_model.dart';
import 'package:flutter/material.dart';

class EditExpensePage extends StatefulWidget {
  static const route = "/expense/edit";

  final ExpenseModel expenseModel;
  const EditExpensePage(this.expenseModel);

  @override
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  void onSubmit({
    required double value,
    required String? description,
  }) async {
    storeModel.value.editExpense(
      widget.expenseModel,
      value: value,
      description: description,
    );

    Navigator.pop(context);
  }

  void onDelete() {
    storeModel.value.deleteExpense(widget.expenseModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseEdit(
      initialValue: widget.expenseModel.value,
      initialDescription: widget.expenseModel.description,
      floatingActionButtonIcon: Icon(Icons.delete),
      onFloatingActionButtonPressed: onDelete,
      onSubmit: onSubmit,
    );
  }
}
