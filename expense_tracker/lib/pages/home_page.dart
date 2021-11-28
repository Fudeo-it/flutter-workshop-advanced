import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/models/store_model.dart';
import 'package:expense_tracker/pages/edit_expense_page.dart';
import 'package:expense_tracker/pages/new_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          header(),
          content(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, NewExpensePage.route),
        label: Text("Spesa"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget header() => Obx(
        () => Container(
          padding: EdgeInsets.all(16),
          color: Colors.green.shade400,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Questo mese".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "€ ${storeModel.value.totalExpenseMonth.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  children: [
                    HeaderExpenseStat(
                      value: storeModel.value.totalExpenseToday,
                      label: "Oggi",
                    ),
                    HeaderExpenseStat(
                      value: storeModel.value.totalExpenseWeek,
                      label: "Settimana",
                    ),
                    HeaderExpenseStat(
                      value: storeModel.value.totalExpenseYear,
                      label: "Anno",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget content() => Obx(
        () => Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -2),
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: storeModel.value.expenses.length,
              itemBuilder: (context, index) => ExpenseTile(
                storeModel.value.expenses[index],
                onPressed: () => Navigator.pushNamed(
                  context,
                  EditExpensePage.route,
                  arguments: storeModel.value.expenses[index],
                ),
              ),
              separatorBuilder: (context, index) => Divider(height: 0),
            ),
          ),
        ),
      );
}

class HeaderExpenseStat extends StatelessWidget {
  final double value;
  final String label;

  const HeaderExpenseStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          children: [
            Text(
              "€ ${value.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.green.shade100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ));
  }
}
