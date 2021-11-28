import 'package:flutter/material.dart';
import 'package:workshop_advanced/components/coin_list_tile.dart';
import 'package:workshop_advanced/components/sliding_up_panel_button.dart';
import 'package:workshop_advanced/models/coin_model.dart';
import 'package:workshop_advanced/themes/colors.dart';

class SlidingUpPanelOverview extends StatelessWidget {
  final CoinModel coinModel;
  final ScrollController scrollController;
  final void Function() onNewDepositPressed;

  const SlidingUpPanelOverview({
    required this.coinModel,
    required this.onNewDepositPressed,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          coinHeader(),
          depositList(),
          newDepositButton(),
        ],
      ),
    );
  }

  Widget coinHeader() => AspectRatio(
        aspectRatio: 1 / 1,
        child: CoinListTile(coinModel),
      );

  Widget depositList() => Expanded(
        child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.symmetric(vertical: 16),
          itemCount: coinModel.deposits.length,
          itemBuilder: (context, index) => DepositListTile(
            amountInUSD: coinModel.deposits[index].amountInUSD,
            purchasePrice: coinModel.deposits[index].purchasePrice,
          ),
        ),
      );

  Widget newDepositButton() => SlidingUpPanelButton(
        text: "Nuovo deposito",
        onPressed: onNewDepositPressed,
      );
}

class DepositListTile extends StatelessWidget {
  final double amountInUSD;
  final double purchasePrice;

  const DepositListTile({
    required this.amountInUSD,
    required this.purchasePrice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.green.withOpacity(0.2),
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 16,
            color: Colors.green.shade300,
          )),
      title: Text(
        "${amountInUSD.toStringAsFixed(0)}\$",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "${purchasePrice.toStringAsFixed(0)}\$",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
