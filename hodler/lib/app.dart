import 'package:flutter/material.dart';
import 'package:workshop_advanced/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.white,
            ),
      ),
      home: HomePage(),
    );
  }
}
