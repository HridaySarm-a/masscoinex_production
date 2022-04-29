import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/dashboard/dashboard_controller_copy.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/dashboard_screen_copy.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/fiat_main/fiat_wallet_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/profile_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/swap_screen.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/models/dashboard_crypto_status_model.dart';

class MainControllerCopy extends GetxController {
  var dashBoardController = Get.put(DashBoardControllerCopy());
  var bottomIndex = 0.obs;
  var isDashboardLoading = false.obs;
  var responseResult = "".obs;
  var resultLength = 0.obs;

  var shouldShowKyc = false.obs;
  var shouldShowBank = false.obs;
  var shouldShowCard = false.obs;
  var shouldShowCurrency = false.obs;
  var shouldShowMenu = false.obs;

  var bankAndCardTitle = "".obs;
  var bankAndCardSubtitle = "".obs;

  var _logger = Logger();
  static const bottomIcons = [
    Icons.dashboard_outlined,
    FontAwesomeIcons.random,
    Icons.account_balance_wallet_outlined,
    FontAwesomeIcons.user,
  ];
  var bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        activeIcon: Icon(Icons.dashboard),
        label: "Dashboard"),
    BottomNavigationBarItem(
        icon: Icon(Icons.shuffle_outlined),
        activeIcon: Icon(Icons.shuffle),
        label: "Swap"),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_outlined),
        activeIcon: Icon(Icons.account_balance_wallet),
        label: "Fiat Wallet"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: "Profile"),
  ];
  var screensCopy = <StatelessWidget>[];

  @override
  void onInit() {
    super.onInit();
    getAllDashboard();
    handleAppLifecycleState();
    screensCopy = [
      DashboardScreenCopy(),
      SwapScreen(),
      FiatWalletScreen(),
      ProfileScreen(),
    ];
  }

  getAllDashboard() async {
    _logger.d("Being Called");
    isDashboardLoading.value = true;
    responseResult.value = "";
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.dashboard),
      headers: _header,
    );
    if (_response.statusCode == 200) {
      isDashboardLoading.value = false;
      _logger.d("Being Called again");
      _box.put(GlobalVals.dashBoard, _response.body);
      responseResult.value = _response.body;
      var _result = DashboardModel.fromJson(json.decode(_response.body));
      resultLength.value = _result.cryptoData.length;
      _logger.d(_response.body);
      _logger.d(_token);
      _logger.d(_result.isMenuShow);
      shouldShowMenu.value = _result.isMenuShow == 1 ? true : false;
      shouldShowCurrency.value = _result.wallet.currency != null ? true : false;
      if ((_result.menu.bank == 1) && (_result.menu.card == 1)) {
        bankAndCardTitle.value = "Bank & Card";
        bankAndCardSubtitle.value = "Bank & Card";
        _logger.d("Bank and Card");
      }
      else if(_result.menu.bank == 1){
        bankAndCardTitle.value = "Bank";
        bankAndCardSubtitle.value = "View & edit your bank details";
        _logger.d("Bank");
      }
      else if(_result.menu.card == 1){
        bankAndCardTitle.value = "Card";
        bankAndCardSubtitle.value = "View & edit your card details";
        _logger.d("Card");
      }
      else{
        _logger.d("None ${_result.menu.bank} and ${_result.menu.card}");
      }

    } else {
      _logger.d("Being Called again error");
      GlobalVals.errorToast("Server Error");
    }
  }

  handleAppLifecycleState() {
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      print('SystemChannels> $msg');
      _logger.d('SystemChannels> $msg');

      switch (msg) {
        case "AppLifecycleState.paused":
          break;
        case "AppLifecycleState.inactive":
          break;
        case "AppLifecycleState.resumed":
          _logger.d("Resumed Main");
          break;
        case "AppLifecycleState.suspending":
          break;
        default:
      }
    });
  }
}
