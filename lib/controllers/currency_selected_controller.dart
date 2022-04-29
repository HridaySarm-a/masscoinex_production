import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/currency_selector_list_model.dart';
import 'package:masscoinex/models/dashboard_crypto_status_model.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:flutter/material.dart';

class CurrencySelectedController extends GetxController {
  var selectedIndex = 0.obs;
  final _box = Hive.box(GlobalVals.hiveBox);
  var _dashboardString = "".obs;
  late DashboardModel dashboardValue;
  @override
  void onInit() {
    super.onInit();
    _dashboardString.value = _box.get(GlobalVals.dashBoard);
    dashboardValue = DashboardModel.fromJson(json.decode(_dashboardString.value));
  }

  var dashBoardCryptoStatusModels = [
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/bitcoin.png",
      cryptoName: "Bitcoin",
      cryptoNameSmall: "BTC",
      cryptoPrice: "0.02245",
      cryptoPriceDollarBuy: "\$12385",
      cryptoPriceDollarSell: "\$12585",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/ripple.png",
      cryptoName: "Ripple",
      cryptoNameSmall: "RPL",
      cryptoPrice: "1.234",
      cryptoPriceDollarBuy: "\$1385",
      cryptoPriceDollarSell: "\$1885",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/eos.png",
      cryptoName: "EOS",
      cryptoNameSmall: "EOS",
      cryptoPrice: "1.44",
      cryptoPriceDollarBuy: "\$2385",
      cryptoPriceDollarSell: "\$2485",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/ether.png",
      cryptoName: "Ether",
      cryptoNameSmall: "ETH",
      cryptoPrice: "11.3456",
      cryptoPriceDollarBuy: "\$1185",
      cryptoPriceDollarSell: "\$1585",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/ion.png",
      cryptoName: "Ion",
      cryptoNameSmall: "ION",
      cryptoPrice: "0.000324",
      cryptoPriceDollarBuy: "\$6385",
      cryptoPriceDollarSell: "\$6885",
      priceColor: GlobalVals.downColor,
    ),
  ];
  var currencySelectedList = [
    // CurrencySelectorListModel(
    //     id: 1, money: "0", values: "SWAP", isSelected: true.obs),
    CurrencySelectorListModel(
        id: 2, money: "5", values: "BUY", isSelected: true.obs),
    CurrencySelectorListModel(
        id: 3, money: "0", values: "SELL", isSelected: true.obs),
    CurrencySelectorListModel(
        id: 4, money: "2", values: "DEPOSIT", isSelected: true.obs),
    CurrencySelectorListModel(
        id: 5, money: "0", values: "WITHDRAW", isSelected: true.obs),
  ];
  /* var currencyScreens = [
    CurrencySwapScreen(),
    BuyScreen(),
    SellScreen(),
    DepositScreen(),
    WithdrawScreen(),
  ]; */
  var bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        activeIcon: Icon(Icons.dashboard),
        label: "Dashboard"),
    BottomNavigationBarItem(
        icon: Icon(Icons.shuffle_outlined),
        activeIcon: Icon(Icons.shuffle),
        label: "History"),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_outlined),
        activeIcon: Icon(Icons.account_balance_wallet),
        label: "Fiat Wallet"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: "Profile"),
  ];
  var currencyCurrentScreens = [];
}
