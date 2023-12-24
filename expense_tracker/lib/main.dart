import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/models/store_model.dart';
import 'package:expense_tracker/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'it_IT';
  await initializeDateFormatting('it_IT', null);

  final databaseConnection = await DatabaseRepository.newConnection();
  GetIt.instance.registerSingleton(databaseConnection);

  await storeModel.value.initialize();

  runApp(App());
}
