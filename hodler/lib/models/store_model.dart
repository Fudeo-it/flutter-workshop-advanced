import 'package:get/get.dart';

import 'package:workshop_advanced/models/coin_deposit_model.dart';
import 'package:workshop_advanced/models/coin_model.dart';
import 'package:workshop_advanced/repositories/coin_repository.dart';

final storeModel = StoreModel().obs;

class StoreModel {
  List<CoinModel> _coins = [];

  Future<void> initialize() async {
    _coins = await CoinRepository.all();
  }

  List<CoinModel> coins({String searchQuery = ""}) {
    return _coins.where((coinModel) {
      return coinModel.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          coinModel.symbol.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  double get totalPortfolioCurrentValue {
    return _coins.fold(0, (total, coinModel) => total + coinModel.totalPortfolioCurrentValue);
  }

  void createCoinDeposit(
    CoinModel coinModel, {
    required double amountInUSD,
    required double purchasePrice,
  }) {
    final depositModel = CoinDepositModel(
      amountInUSD: amountInUSD,
      purchasePrice: purchasePrice,
    );

    coinModel.deposits.insert(0, depositModel);
    storeModel.refresh();
  }
}
