import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sudoku/model/game_model.dart';

class KeyboardNumbers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => gameModel.value.completed
        ? SizedBox()
        : SizedBox(
            width: double.infinity,
            height: 50,
            child: Row(
              children: List.generate(
                9,
                (index) => Expanded(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: InkWell(
                      splashColor: Colors.purple.shade100,
                      onTap: () => gameModel.value.setValue(index + 1),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
  }
}
