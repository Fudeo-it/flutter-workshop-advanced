import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sudoku/model/game_model.dart';

class SudokuBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade300,
        child: Obx(
          () => GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemCount: gameModel.value.game.length,
            itemBuilder: (context, index) => SudokuQuadrant(model: gameModel.value.game[index]),
          ),
        ));
  }
}

class SudokuQuadrant extends StatelessWidget {
  final List<CellModel> model;
  const SudokuQuadrant({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(6),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemCount: model.length,
        itemBuilder: (context, index) => SudokuQuadrantCell(model: model[index]),
      ),
    );
  }
}

class SudokuQuadrantCell extends StatelessWidget {
  final CellModel model;
  const SudokuQuadrantCell({required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gameModel.value.setFocus(model),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
          boxShadow: gameModel.value.isCellInFocus(model)
              ? [
                  BoxShadow(
                    color: Colors.purple.shade800,
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.purple,
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            model.value == 0 ? "" : model.value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: model.editable ? FontWeight.normal : FontWeight.bold,
              color: model.editable ? Colors.black : Colors.purple.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
