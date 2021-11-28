import 'package:flutter/material.dart';
import 'package:workshop_advanced/components/sliding_up_panel_button.dart';

class SlidingUpPanelCreateDeposit extends StatelessWidget {
  final void Function({
    required double amountInUSD,
    required double purchasePrice,
  }) onSubmit;

  final amountInUSDController = TextEditingController();
  final purchasePriceController = TextEditingController();

  SlidingUpPanelCreateDeposit({
    required this.onSubmit,
  });

  void onCreateDeposit() {
    final amountInUSD = double.tryParse(amountInUSDController.text.trim()) ?? 0.0;
    final purchasePrice = double.tryParse(purchasePriceController.text.trim()) ?? 0.0;

    onSubmit(
      amountInUSD: amountInUSD,
      purchasePrice: purchasePrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          title("Importo totale"),
          field(amountInUSDController),
          title("Acquistato a"),
          field(purchasePriceController),
          Expanded(child: SizedBox()),
          createDepositButton(),
        ],
      ),
    );
  }

  Widget title(String text) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        ),
      );

  Widget field(TextEditingController controller) => TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixText: "\$",
          hintText: "0.00",
          border: InputBorder.none,
        ),
      );

  Widget createDepositButton() => SlidingUpPanelButton(
        text: "HODL!",
        onPressed: onCreateDeposit,
      );
}
