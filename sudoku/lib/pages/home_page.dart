import 'package:flutter/material.dart';
import 'package:sudoku/components/keyboard_numbers.dart';
import 'package:sudoku/components/sudoku_board.dart';
import 'package:sudoku/components/timer.dart';
import 'package:sudoku/model/game_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() => AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "SUDOKU",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.purple,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              gameModel.value.newGame();
              gameModel.refresh();
            },
            icon: Icon(
              Icons.restart_alt,
              color: Colors.black,
            ),
          ),
        ],
      );

  Widget body() => Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SudokuBoard(),
            SizedBox(height: 16),
            Timer(),
            SizedBox(height: 32),
            KeyboardNumbers(),
          ],
        ),
      );
}
