import 'package:flutter/material.dart';
import 'package:workshop_advanced/app.dart';
import 'package:workshop_advanced/models/store_model.dart';

void main() async {
  await storeModel.value.initialize();

  runApp(App());
}
