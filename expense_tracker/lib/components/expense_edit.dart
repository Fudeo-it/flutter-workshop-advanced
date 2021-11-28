import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class ExpenseEdit extends StatefulWidget {
  final double? initialValue;
  final String? initialDescription;
  final Widget? floatingActionButtonIcon;
  final void Function()? onFloatingActionButtonPressed;
  final void Function({
    required double value,
    required String? description,
  }) onSubmit;

  const ExpenseEdit({
    this.initialValue,
    this.initialDescription,
    this.floatingActionButtonIcon,
    this.onFloatingActionButtonPressed,
    required this.onSubmit,
  });

  @override
  _ExpenseEditState createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isTappedDown = false;

  @override
  void initState() {
    super.initState();

    valueController.text = widget.initialValue?.toString() ?? "";
    descriptionController.text = widget.initialDescription ?? "";
  }

  void onSubmit() async {
    final value = double.tryParse(valueController.text.trim()) ?? 0;
    final description = descriptionController.text.trim();

    if (value == 0) {
      Get.snackbar(
        "Nope!",
        "Non puoi creare una spesa con un valore pari a 0.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.green.shade900,
        backgroundColor: Colors.green.withOpacity(0.15),
      );
      return;
    }

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    widget.onSubmit(
      value: value,
      description: description.isEmpty ? null : description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: InkWell(
        onLongPress: onSubmit,
        onHighlightChanged: (highlighted) => setState(
          () => isTappedDown = highlighted,
        ),
        highlightColor: Colors.green.shade400,
        splashColor: Colors.green.shade100,
        focusColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputPrice(),
            inputDescription(),
          ],
        ),
      ),
      floatingActionButton: widget.onFloatingActionButtonPressed == null
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.green.shade200,
              foregroundColor: Colors.green.shade900,
              onPressed: widget.onFloatingActionButtonPressed,
              child: widget.floatingActionButtonIcon,
            ),
    );
  }

  Widget inputPrice() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "€",
            style: TextStyle(
              color: isTappedDown ? Colors.white : Colors.green.shade700,
              fontSize: 50,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 20),
          IntrinsicWidth(
            child: TextField(
              controller: valueController,
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                color: isTappedDown ? Colors.white : Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: "0.00",
                hintStyle: TextStyle(
                  color: Colors.green.shade200,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      );

  Widget inputDescription() => TextField(
        controller: descriptionController,
        autofocus: false,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: isTappedDown ? Colors.white : Colors.green.shade700,
          fontWeight: FontWeight.w600,
        ),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: "Descrizione (opzionale)",
          hintStyle: TextStyle(
            color: Colors.green.shade200,
          ),
          border: InputBorder.none,
        ),
      );
}
