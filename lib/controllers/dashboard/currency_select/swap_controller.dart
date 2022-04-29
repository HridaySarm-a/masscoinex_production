import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/currency/sell/insert_amount_model.dart';
import 'package:masscoinex/models/currency/sell/save_sell_model.dart';
import 'package:masscoinex/models/currency/swap/crypto_value_convert_model.dart';
import 'package:masscoinex/models/currency/swap/get_crypto_coins_model.dart';
import 'package:masscoinex/models/currency/swap/swap_percent_model.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/routes/route_list.dart';

class SwapController extends GetxController {
  final _box = Hive.box(GlobalVals.hiveBox);
  var _dashboardString = "".obs;
  late DashboardModel dashboardValue;
  var selectedCurrency = "".obs;
  var cryptoValueController = TextEditingController(text: "0");
  var amountController = TextEditingController(text: "0");
  var denominatedValue = TextEditingController(text: "0");
  var percentValue = TextEditingController(text: "0");
  final _logger = Logger();
  var isRefreshed = false.obs;
  var isBought = true.obs;
  var isTypeFinished = true.obs;

  /* Getting coin info's */
  var index = 0.obs;

  /*Api responses*/
  /*Coin List*/
  var coinCode = "bitcoin".obs;
  var coinList = <UserCoinsList>[].obs;
  var dropdownValueTo = "".obs;
  var dropDownValueToList = <String>[].obs;
  var isCoinLoaded = true.obs;

  /*Save Swap*/
  var transactionFeeRate = "".obs;
  var denominatedCryptoValue = "".obs;
  var toSelectedCoin = "".obs;
  var fromSelectedCoin = "".obs;
  var fromCryptoValue = "".obs;
  var toCryptoValue = "".obs;

  @override
  void onInit() {
    super.onInit();
    _dashboardString.value = _box.get(GlobalVals.dashBoard);
    dashboardValue =
        DashboardModel.fromJson(json.decode(_dashboardString.value));
    selectedCurrency.value = dashboardValue.wallet.currency != null ? dashboardValue.wallet.currency : "10.0";
    settingTextFieldsToZero();
    getCoinsList();
  }

  insertPercentage(String percentage) async {
    isTypeFinished.value = false;
    isRefreshed.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    _logger.d(dashboardValue.cryptoData[index.value].coinName.toLowerCase());
    final Map<String, dynamic> _body = {
      "fromselectedCoin":
          dashboardValue.cryptoData[index.value].coinName.toLowerCase(),
      "toselectedCoin": dropdownValueTo.value,
      "cryptoPercent": percentage,
    };
    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getPercentSwapCryptoAmount),
        body: _body,
        headers: _header);
    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = swapPercentModelFromJson(_response.body);
      if (_result.code.toString() == "1") {
        isRefreshed.value = true;
        transactionFeeRate.value = _result.result.coinBuyTransactionRate == null
            ? "0"
            : _result.result.coinBuyTransactionRate.toString();
        denominatedCryptoValue.value =
            _result.result.actualVolumeOfCoinUserGet.toString();
        toSelectedCoin.value = coinCode.value;
        fromSelectedCoin.value = dropdownValueTo.value;
        fromCryptoValue.value =
            _result.result.selectedCoinWalletValue.toString();
        toCryptoValue.value =
            _result.result.actualVolumeOfCoinUserGet.toString();

        cryptoValueController.text =
            _result.result.selectedCoinWalletValue.toString();
        amountController.text = _result.result.volumeOfCoin.toString();
        denominatedValue.text =
            _result.result.actualVolumeOfCoinUserGet.toString();
      } else {
        GlobalVals.errorToast(_result.message);
        settingTextFieldsToZero();
      }
    } else {
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
      settingTextFieldsToZero();
    }
  }

  insertValue(String cryptoValues) async {
    isTypeFinished.value = false;
    isRefreshed.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    _logger.d(dashboardValue.cryptoData[index.value].coinName.toLowerCase());
    final Map<String, dynamic> _body = {
      "fromselectedCoin":
          dashboardValue.cryptoData[index.value].coinName.toLowerCase(),
      "toselectedCoin": dropdownValueTo.value,
      "crypto_value": cryptoValues,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getFiatSwapCryptoAmount),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = cryptoValueConvertModelFromJson(_response.body);
      if (_result.code == "1") {
        isRefreshed.value = true;
        /*Setting values*/
        transactionFeeRate.value = _result.result.coinBuyTransactionRate == null
            ? "0"
            : _result.result.coinBuyTransactionRate.toString();
        denominatedCryptoValue.value =
            _result.result.actualVolumeOfCoinUserGet.toString();
        toSelectedCoin.value = coinCode.value;
        fromSelectedCoin.value = dropdownValueTo.value;
        fromCryptoValue.value =
            _result.result.selectedCoinWalletValue.toString();
        toCryptoValue.value =
            _result.result.actualVolumeOfCoinUserGet.toString();

        cryptoValueController.text =
            _result.result.selectedCoinWalletValue.toString();
        amountController.text = _result.result.volumeOfCoin.toString();
        denominatedValue.text =
            _result.result.actualVolumeOfCoinUserGet.toString();
      } else {
        isRefreshed.value = false;
        Fluttertoast.showToast(
          msg: _result.result.message,
          backgroundColor: Colors.red,
        );
        settingTextFieldsToZero();
      }
    } else {
      isTypeFinished.value = true;
      settingTextFieldsToZero();
      isRefreshed.value = true;
      Fluttertoast.showToast(
        msg: "Server error: ${_response.statusCode}",
        backgroundColor: Colors.red,
      );
    }
  }

  withdrawCrypto(int _index) async {
    if (!isRefreshed.value) {
      Fluttertoast.showToast(
        msg: "Please enter your withdraw amount",
        backgroundColor: Colors.red,
      );
    } else {
      isBought.value = false;
      final _userInfo =
          UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
      final _token = _userInfo.result.token;
      Map<String, String> _header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      _logger.d(dashboardValue.cryptoData[index.value].coinName.toLowerCase());
      final Map<String, dynamic> _body = {
        "transaction_fee_rate": transactionFeeRate.value,
        "denominated_crypto_value": denominatedCryptoValue.value,
        "toselectedCoin": toSelectedCoin.value,
        "fromselectedCoin": fromSelectedCoin.value,
        "from_crypto_value": fromCryptoValue.value,
        "to_crypto_value": toCryptoValue.value,
        "privacy": "1",
      };
      var _response = await http.post(
          Uri.parse(ApiRoutes.baseUrl + ApiRoutes.saveSwapCrypto),
          body: _body,
          headers: _header);
      _logger.d(_response.body);
      if (_response.statusCode == 200) {
        isBought.value = true;
        final _saveSell = saveSellModelFromJson(_response.body);
        if (_saveSell.code == "1") {
          Fluttertoast.showToast(
            msg: _saveSell.message.toString(),
            backgroundColor: Colors.green,
          );
          transactionFeeRate.value = "";
          denominatedCryptoValue.value = "";
          toSelectedCoin.value = "";
          fromSelectedCoin.value = "";
          fromCryptoValue.value = "";
          toCryptoValue.value = "";
          isRefreshed.value = false;
          settingTextFieldsToZero();
          Get.toNamed(Routes.transactionHistory, arguments: [
            _index,
          ]);
        } else {
          Fluttertoast.showToast(
            msg: _saveSell.message.toString(),
            backgroundColor: Colors.red,
          );
        }
      } else {
        isBought.value = true;
        Fluttertoast.showToast(
          msg: "Server error",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  settingTextFieldsToZero() {
    amountController.text = "0";
    cryptoValueController.text = "0";
    denominatedValue.text = "0";
  }

  getCoinsList() async {
    isCoinLoaded.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    final _dummyToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjFiOGEyOGNhNzU5MmVjMTU5NmVkMTZmYmYxZDk4YzNkYTFmNmVmNzU4ZDQ1YjI0NjFhNWFjZjMxZWViODRhNDhmZTJhZTg0ZTJmMDJkNzk3In0.eyJhdWQiOiIxIiwianRpIjoiMWI4YTI4Y2E3NTkyZWMxNTk2ZWQxNmZiZjFkOThjM2RhMWY2ZWY3NThkNDViMjQ2MWE1YWNmMzFlZWI4NGE0OGZlMmFlODRlMmYwMmQ3OTciLCJpYXQiOjE2MzYyNjcwODAsIm5iZiI6MTYzNjI2NzA4MCwiZXhwIjoxNjY3ODAzMDgwLCJzdWIiOiIxODA0Iiwic2NvcGVzIjpbXX0.hjT4KYGHcJJ92IXT6-if1V9CXpnJusv5h2Lkp6o0Z3nKJXpKkXFWC9yoWIIpLcw39cIrl02xW6QtSWDUJTD2xvtOpvuniwtfW94k1iEHcg_TmBi77A_2CQKp28E-y3deNueLccjRgWfIvgv9L9kUlCYGCq0-ZDSUsV8BnDIrnIMcP7av-iKtAx4P7_6bGWea4cf8ZDJDUHBnG4dnpgy3hbpE37YVNgixA5JiSbBB_fl4Dy9DfemVYYjyDQNY28whJvTMpcnPj5tYFervVJO8G5ggCUvXCAL8kgs2jjIj9kt7jmF_2RPaDzaX5uMcejrj2gVD6Vb_TdBfTClYhJH2La63ddtzAXNLQRF71rByk5tSbj-BBALesFK76SRONSLHlOdGmGz_ooImOm2fxvAQ7Hr68ULJn7ZCpz672Jhvg7vfXVV4-guvom5VR1RVApmfEV6c4Y4jZlGEZa3IQck9caZ1X6d1XmDgIX_i5HzS_oZjtWf5CsrTvrJTcE0LEbcJHhHQPcfaTaRkMpmjXP_hIEqXzJtTe8PJAdWHVa-4HIGBE_vc-nebCahH41FYtHX_2evQ_7NPcVASVXPaUGOSsJcLat3-LX50mMPjXwyJSy9jANIC0WtwSkuoBNbehG8DvK5uq71fpRzPxMwN4bmL4MfhIJLbXUMuxXKE2nLuznU";
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    _logger.d(_token);

    var _response = await http.get(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getUserCryptoCoins),
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isCoinLoaded.value = true;
      var _result = getCryptoCoinsModelFromJson(_response.body);
      if (_result.code == "1") {
        if (_result.result.status) {
          coinList.value = _result.result.userCoinsList;
          if (dashboardValue.cryptoData[index.value].coinName !=
              _result.result.userCoinsList.first.coinCode.capitalizeFirst!) {
            dropdownValueTo.value =
                _result.result.userCoinsList.first.coinCode.capitalizeFirst!;
            _logger.d(
                "Coin name: ${dashboardValue.cryptoData[index.value].coinName} and coin list first name: ${_result.result.userCoinsList.first.coinCode.capitalizeFirst!}");
          } else {
            if (_result.result.userCoinsList.length >= 2) {
              dropdownValueTo.value =
                  _result.result.userCoinsList[1].coinCode.capitalizeFirst!;
            }
          }

          for (var coinCode in _result.result.userCoinsList) {
            dropDownValueToList.value.add(coinCode.coinCode);
          }
        }
      } else {
        Fluttertoast.showToast(
            msg: _result.message, backgroundColor: Colors.red);
      }
    } else {
      isCoinLoaded.value = true;
      Fluttertoast.showToast(
          msg: "Server error: ${_response.statusCode}",
          backgroundColor: Colors.red);
    }
  }
}
