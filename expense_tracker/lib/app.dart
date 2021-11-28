import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/pages/edit_expense_page.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/pages/new_expense_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        final pageBuilder = <String, WidgetBuilder>{
          HomePage.route: (_) => HomePage(),
          NewExpensePage.route: (_) => NewExpensePage(),
          EditExpensePage.route: (_) => EditExpensePage(settings.arguments as ExpenseModel),
        }[settings.name];

        return MaterialPageRoute(builder: pageBuilder!);
      },
    );
  }
}
