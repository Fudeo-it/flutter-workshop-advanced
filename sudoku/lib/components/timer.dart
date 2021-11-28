import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sudoku/model/game_model.dart';

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => gameModel.value.completed
        ? Text(
            "GIOCO FINITO: ${gameModel.value.timeElapsed}",
            style: TextStyle(
              color: gameModel.value.correct ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          )
        : Text(
            "(${gameModel.value.timeElapsed})",
            style: TextStyle(color: Colors.grey.shade800, letterSpacing: 1),
          ));
  }
}
