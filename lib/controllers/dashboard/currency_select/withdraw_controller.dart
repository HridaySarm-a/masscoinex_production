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
import 'package:masscoinex/models/currency/withdraw_percent_model.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/routes/route_list.dart';

class WithdrawController extends GetxController {
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
  /*Common*/
  var coinSellTransactionRate = "".obs;
  var coinSellTransactionVolumeFees = "".obs;
  var userCoinAmountAfterFees = "".obs; //this goes to total or something

  /* Save sell val*/
  var coinCode = "bitcoin".obs;
  var cryptoAmount = "".obs;
  var cryptoValue = "".obs;
  var transactionFeeRate = "".obs;
  var transactionFee = "".obs;
  var coinValue = "".obs;

  @override
  void onInit() {
    super.onInit();
    _dashboardString.value = _box.get(GlobalVals.dashBoard);
    dashboardValue =
        DashboardModel.fromJson(json.decode(_dashboardString.value));
    selectedCurrency.value = dashboardValue.wallet.currency != null ? dashboardValue.wallet.currency: "Currency Name";
    settingTextFieldsToZero();
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
      "coin_code":
      dashboardValue.cryptoData[index.value].coinName.toLowerCase(),
      "crypto_percent": percentage,
    };
    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl +
            ApiRoutes.getPercentWithdrawCryptoValue),
        body: _body,
        headers: _header);
    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = withdrawPercentModelFromJson(_response.body);
      if (_result.code.toString() == "1") {
        isRefreshed.value = true;
        coinCode.value =
            dashboardValue.cryptoData[index.value].coinName.toLowerCase();
        coinValue.value = _result.result.cryptoAmount.toString();
        cryptoAmount.value = _result.result.cryptoAmount.toString();
        transactionFeeRate.value =
            _result.result.transactionFeeRate.toString();
        transactionFee.value =
            _result.result.transactionFee.toString();
        cryptoValue.value = _result.result.cryptoValue.toString();
        /* Prepare for buy */
        amountController.text = _result.result.cryptoAmount.toString();
        denominatedValue.text = _result.result.cryptoValue.toString();
        cryptoValueController.text = _result.result.cryptoValue.toString();
      } else {
        GlobalVals.errorToast(_result.message);
        settingTextFieldsToZero();
      }
    } else {
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
      settingTextFieldsToZero();
    }
  }

  insertAmount(String amount) async {
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
      "coin_code":
          dashboardValue.cryptoData[index.value].coinName.toLowerCase(),
      "crypto_amount": amount,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getFiatWithdrawCryptoValue),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = insertAmountModelFromJson(_response.body);
      if (_result.code == "1") {
        if (!_result.result.status) {
          isRefreshed.value = false;
          Fluttertoast.showToast(
            msg: _result.result.message,
            backgroundColor: Colors.red,
          );
        } else {
          isRefreshed.value = true;
          /*Setting values*/
          cryptoAmount.value = amount;
          cryptoValue.value = _result.result.userCoinAmount;
          transactionFeeRate.value =
              _result.result.coinSellTransactionRate.toString();
          transactionFee.value =
              _result.result.coinSellTransactionVolumeFees.toString();
          coinValue.value = _result.result.userCoinAmountAfterFees.toString();
          userCoinAmountAfterFees.value =
              _result.result.userCoinAmountAfterFees.toString();

          amountController.text = amount;
          cryptoValueController.text = cryptoValue.value;
          denominatedValue.text = userCoinAmountAfterFees.value;
        }
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
      Fluttertoast.showToast(msg: "Server error: ${_response.statusCode}");
    }
  }

  /*insertValue(String cryptoValues) async {
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
      "coin_code":
          dashboardValue.cryptoData[index.value].coinName.toLowerCase(),
      "crypto_value": cryptoValues,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getFiatSellCryptoAmount),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = insertAmountModelFromJson(_response.body);
      if (_result.code == "1") {
        if (!_result.result.status) {
          isRefreshed.value = false;
          Fluttertoast.showToast(
            msg: _result.result.message,
            backgroundColor: Colors.red,
          );
        } else {
          isRefreshed.value = true;
          */ /*Setting values*/ /*
          cryptoAmount.value = _result.result.userCoinAmount;
          cryptoValue.value = cryptoValues;
          transactionFeeRate.value =
              _result.result.coinSellTransactionRate.toString();
          transactionFee.value =
              _result.result.coinSellTransactionVolumeFees.toString();
          coinValue.value = _result.result.userCoinAmountAfterFees.toString();
          userCoinAmountAfterFees.value =
              _result.result.userCoinAmountAfterFees.toString();

          amountController.text = cryptoAmount.value;
          cryptoValueController.text = cryptoValues;
          denominatedValue.text = userCoinAmountAfterFees.value;
        }
      } else {
        isRefreshed.value = false;
        Fluttertoast.showToast(
          msg: _result.result.message,
          backgroundColor: Colors.red,
        );
      }
    } else {
      isTypeFinished.value = true;
      settingTextFieldsToZero();
      isRefreshed.value = true;
      Fluttertoast.showToast(msg: "Server error: ${_response.statusCode}");
    }
  }*/

  saveWithdraw(int _index) async {
    if (!isRefreshed.value) {
      Fluttertoast.showToast(
        msg: "Please enter your buy amount",
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
        "coin_code": coinCode.value,
        "crypto_amount": cryptoAmount.value,
        "crypto_value": cryptoValue.value,
        "coin_address": "QWERTYASDFGH",
        "transaction_fee_rate": transactionFeeRate.value,
        "transaction_fee": transactionFee.value,
        "coin_value": coinValue.value,
        "privacy": "1",
        "withdraw_coin_address": "POIYTRELKJHGFD",
        "tag": "zxcvbn",
      };
      var _response = await http.post(
          Uri.parse(ApiRoutes.baseUrl + ApiRoutes.saveWithdrawCrypto),
          body: _body,
          headers: _header);
      _logger.d(_response.body);
      if (_response.statusCode == 200) {
        isBought.value = true;
        try{
          final _saveSell = saveSellModelFromJson(_response.body);
          if (_saveSell.code == "1") {
            Fluttertoast.showToast(
              msg: _saveSell.message.toString(),
              backgroundColor: Colors.green,
            );
            coinValue.value = "";
            cryptoAmount.value = "";
            transactionFeeRate.value = "";
            transactionFee.value = "";
            cryptoValue.value = "";
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
        }
        catch(e){
          Fluttertoast.showToast(
            msg: _response.body,
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
}
