import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:workshop_advanced/models/coin_model.dart';

class CoinListTile extends StatelessWidget {
  final CoinModel coinModel;
  final void Function()? onPressed;

  const CoinListTile(
    this.coinModel, {
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.grey.shade800,
          ),
        ),
        child: Column(
          children: [
            content(),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget content() => Expanded(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${coinModel.name} [${coinModel.symbol}]".toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AutoSizeText(
                "${coinModel.price.toStringAsFixed(2)}\$",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CoinPeriodStat(
                    label: "Oggi",
                    value: coinModel.percentChange24h,
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey.shade800,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  CoinPeriodStat(
                    label: "Settimana",
                    value: coinModel.percentChange7d,
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget footer() => Visibility(
        visible: coinModel.deposits.isNotEmpty,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: Colors.grey.shade800,
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${coinModel.totalPortfolioDeposited.toStringAsFixed(0)}\$",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "/",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              Text(
                "${coinModel.totalPortfolioIncrease.toStringAsFixed(0)}\$",
                style: TextStyle(
                  fontSize: 12,
                  color: coinModel.totalPortfolioIncrease > 0 ? Colors.green.shade300 : Colors.red.shade300,
                ),
              ),
            ],
          ),
        ),
      );
}

class CoinPeriodStat extends StatelessWidget {
  final double value;
  final String label;

  const CoinPeriodStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${value.toStringAsFixed(1)}%",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: true ? Colors.green.shade300 : Colors.red.shade300,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 8,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
