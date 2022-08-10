import 'package:flutter/foundation.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:get/get.dart';

final gameModel = GameModel().obs;

class GameModel {
  late List<List<CellModel>> game;
  late List<List<CellModel>> gameSolved;
  late CellModel cellInFocus;
  late DateTime startDate;
  late DateTime currentDate;

  GameModel() {
    newGame();
  }

  void newGame() {
    var sudokuGenerator = SudokuGenerator(emptySquares: 26);
    SudokuUtilities.printSudoku(sudokuGenerator.newSudoku);

    game = [0, 1, 2, 3, 4, 5, 6, 7, 8].map((quadrantIndex) {
      return [0, 1, 2, 3, 4, 5, 6, 7, 8].map((cellIndex) {
        final row = (cellIndex ~/ 3) + (quadrantIndex ~/ 3 * 3);
        final column = (cellIndex % 3) + (quadrantIndex % 3 * 3);

        int cellValue = sudokuGenerator.newSudoku[row][column];

        return CellModel(
          value: cellValue,
          editable: cellValue == 0,
        );
      }).toList();
    }).toList();

    gameSolved = sudokuGenerator.newSudokuSolved
        .map((quadrant) => quadrant
            .map((cellValue) => CellModel(
                  value: cellValue,
                  editable: false,
                ))
            .toList())
        .toList();

    cellInFocus = game
        .firstWhere((quadrant) => quadrant.any((cellModel) => cellModel.value == 0))
        .firstWhere((cellModel) => cellModel.value == 0);

    startDate = DateTime.now();
    currentDate = DateTime.now();
    _startTimer();
  }

  void _startTimer() async {
    if (!completed) {
      await Future.delayed(Duration(seconds: 1));
      currentDate = DateTime.now();
      gameModel.refresh();
      _startTimer();
    }
  }

  void setValue(int value) {
    if (!completed) {
      cellInFocus.value = value;
      gameModel.refresh();
    }
  }

  void setFocus(CellModel cellModel) {
    if (cellModel.editable) {
      cellInFocus = cellModel;
      gameModel.refresh();
    }
  }

  bool isCellInFocus(CellModel cellModel) {
    return cellInFocus == cellModel;
  }

  String get timeElapsed {
    final dateDifference = currentDate.difference(startDate);
    final minutes = dateDifference.inMinutes.remainder(60);
    final seconds = dateDifference.inSeconds.remainder(60);
    return "${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds";
  }

  bool get completed {
    return game.every((quadrant) => quadrant.every((cell) => cell.value != 0));
  }

  bool get correct {
    final gameCells = game
        .expand(
          (quadrant) => quadrant.expand((cell) => [cell.value]),
        )
        .toList();

    final gameSolvedCells = gameSolved
        .expand(
          (quadrant) => quadrant.expand((cell) => [cell.value]),
        )
        .toList();

    return listEquals(gameCells, gameSolvedCells);
  }
}

class CellModel {
  int value;
  bool editable;

  CellModel({
    required this.value,
    required this.editable,
  });
}
