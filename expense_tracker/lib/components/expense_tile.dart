import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel model;
  final void Function() onPressed;

  const ExpenseTile(
    this.model, {
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "€ ${model.value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade900),
            ),
          ),
        ),
      ),
      title: Text(DateFormat("dd MMMM").format(model.createdOn)),
      subtitle: Text(model.description ?? "-"),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade300),
    );
  }
}
