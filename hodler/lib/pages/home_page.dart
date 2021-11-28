import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:workshop_advanced/components/coin_list_tile.dart';
import 'package:workshop_advanced/components/sliding_up_panel_create_deposit.dart';
import 'package:workshop_advanced/components/sliding_up_panel_overview.dart';
import 'package:workshop_advanced/models/coin_model.dart';
import 'package:workshop_advanced/models/store_model.dart';
import 'package:workshop_advanced/themes/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final slidingUpPanelController = PanelController();

  String searchQuery = "";
  bool createDepositMode = false;
  CoinModel? currentCoin;

  void onSearchChanged(String searchQuery) {
    setState(() {
      this.searchQuery = searchQuery;
    });
  }

  void onCoinListTilePressed(CoinModel coinModel) {
    setState(() {
      currentCoin = coinModel;
    });

    if (slidingUpPanelController.isAttached) {
      slidingUpPanelController.open();
    }
  }

  void onCreateDeposit({
    required double amountInUSD,
    required double purchasePrice,
  }) {
    storeModel.value.createCoinDeposit(
      currentCoin!,
      amountInUSD: amountInUSD,
      purchasePrice: purchasePrice,
    );

    setState(() {
      createDepositMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SlidingUpPanel(
        controller: slidingUpPanelController,
        onPanelClosed: () {
          setState(() {
            createDepositMode = false;
          });
        },
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: ((MediaQuery.of(context).size.width) - 320) / 2),
        color: Colors.black,
        backdropEnabled: true,
        backdropOpacity: 0.75,
        border: Border.symmetric(
          vertical: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        panelBuilder: (ScrollController scrollController) => currentCoin == null
            ? SizedBox()
            : createDepositMode
                ? SlidingUpPanelCreateDeposit(
                    onSubmit: onCreateDeposit,
                  )
                : SlidingUpPanelOverview(
                    coinModel: currentCoin!,
                    scrollController: scrollController,
                    onNewDepositPressed: () {
                      setState(() {
                        createDepositMode = true;
                      });
                    },
                  ),
        body: body(),
      ),
    );
  }

  Widget body() => Column(
        children: [
          searchBar(),
          coinGridView(),
          footer(),
        ],
      );

  Widget searchBar() => Container(
        width: 300,
        height: 35,
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey.shade800,
            )),
        child: Center(
          child: TextField(
            onChanged: onSearchChanged,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              isDense: true,
              icon: Icon(Icons.search),
              hintText: "Cerca crypto",
              border: InputBorder.none,
            ),
          ),
        ),
      );

  Widget coinGridView() => Obx(() {
        final coins = storeModel.value.coins(searchQuery: searchQuery);

        return Expanded(
            child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: coins.length,
          itemBuilder: (context, index) => CoinListTile(
            coins[index],
            onPressed: () => onCoinListTilePressed(coins[index]),
          ),
        ));
      });

  Widget footer() => Obx(() => Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        color: ThemeColors.accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Valore\nPortafoglio".toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontSize: 12,
              ),
            ),
            Text(
              "${storeModel.value.totalPortfolioCurrentValue.toStringAsFixed(0)}\$",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ));
}
