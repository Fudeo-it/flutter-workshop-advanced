import 'package:workshop_advanced/models/coin_deposit_model.dart';

class CoinModel {
  final String name;
  final String symbol;
  final double price;
  final double percentChange24h;
  final double percentChange7d;
  List<CoinDepositModel> deposits = [];

  CoinModel({
    required this.name,
    required this.symbol,
    required this.price,
    required this.percentChange24h,
    required this.percentChange7d,
  });

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    final name = map["name"];
    final symbol = map["symbol"];
    final price = map["quote"]["USD"]["price"];
    final percentChange24h = map["quote"]["USD"]["percent_change_24h"];
    final percentChange7d = map["quote"]["USD"]["percent_change_7d"];

    return CoinModel(
      name: name,
      symbol: symbol,
      price: price,
      percentChange24h: percentChange24h,
      percentChange7d: percentChange7d,
    );
  }

  double get totalPortfolioCurrentValue {
    return deposits.fold(0, (total, depositModel) {
      final numbersOfCoinsPurchased = depositModel.amountInUSD / depositModel.purchasePrice;

      return numbersOfCoinsPurchased * price;
    });
  }

  double get totalPortfolioIncrease {
    final totalDeposited = totalPortfolioDeposited;
    final totalCurrentValue = totalPortfolioCurrentValue;

    return totalCurrentValue - totalDeposited;
  }

  double get totalPortfolioDeposited {
    return deposits.fold(0, (total, depositModel) {
      return total + depositModel.amountInUSD;
    });
  }
}
