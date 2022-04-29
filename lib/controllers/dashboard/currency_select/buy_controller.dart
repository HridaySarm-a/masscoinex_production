import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/currency/buy/buy_amount_to_value_model.dart';
import 'package:masscoinex/models/currency/buy/buy_model.dart';
import 'package:masscoinex/models/currency/buy/buy_percent_model.dart';
import 'package:masscoinex/models/currency/buy/buy_value_to_amount_model.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/routes/route_list.dart';

class BuyController extends GetxController {
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

  /* Api get values */
  var coinCode = "bitcoin".obs;

  /* Api retrun values */
  var actualCoinValue = "".obs;
  var coinValue = "".obs;
  var cryptoAmount = "".obs;
  var receivedCoinValue = "".obs;
  var transactionFee = "".obs;
  var transactionFeeRate = "".obs;
  var cryptoValue = "".obs;

  @override
  void onInit() {
    super.onInit();
    _dashboardString.value = _box.get(GlobalVals.dashBoard);
    dashboardValue =
        DashboardModel.fromJson(json.decode(_dashboardString.value));
    /* coinCode.value =
        dashboardValue.cryptoData[index.value].coinName.toLowerCase(); */
    selectedCurrency.value = dashboardValue.wallet.currency != null ? dashboardValue.wallet.currency : "Currency Name";
  }

  buyCoin(int _index) async {
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
        "coin_value": coinValue.value,
        "crypto_amount": cryptoAmount.value,
        "coin_address": "",
        "transaction_fee_rate": transactionFeeRate.value,
        "transaction_fee": transactionFee.value,
        "crypto_value": cryptoValue.value,
        "privacy": "1",
      };
      var _response = await http.post(
          Uri.parse(ApiRoutes.baseUrl + ApiRoutes.buyFiatToCrypto),
          body: _body,
          headers: _header);
      _logger.d(_response.body);
      if (_response.statusCode == 200) {
        isBought.value = true;
        final _buyModel = buyModelFromJson(_response.body);
        if (_buyModel.code == "1") {
          Fluttertoast.showToast(
            msg: _buyModel.message.toString(),
            backgroundColor: Colors.green,
          );
          coinValue.value = "";
          cryptoAmount.value = "";
          transactionFeeRate.value = "";
          transactionFee.value = "";
          cryptoValue.value = "";
          amountController.text = "";
          cryptoValueController.text = "";
          denominatedValue.text = "";
          isRefreshed.value = false;
          Get.toNamed(Routes.transactionHistory, arguments: [
            _index,
          ]);
        } else {
          Fluttertoast.showToast(
            msg: _buyModel.message.toString(),
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

  getPercent(String percentage) async {
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
            ApiRoutes.getBuyCryptoFiatPercentValueGetFiatCryptoAmount),
        body: _body,
        headers: _header);
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = buyPercentModelFromJson(_response.body);
      if (_result.code.toString() == "1") {
        if (!_result.result.status) {
          isRefreshed.value = false;
          Fluttertoast.showToast(
            msg: _result.result.message,
            backgroundColor: Colors.red,
          );
          settingTextFieldsToZero();
        } else {
          isRefreshed.value = true;
          coinCode.value =
              dashboardValue.cryptoData[index.value].coinName.toLowerCase();
          coinValue.value = _result.result.receivedCoinValue.toString();
          cryptoAmount.value = _result.result.receivedCoinValue.toString();
          transactionFeeRate.value =
              _result.result.coinBuyTransactionRate.toString();
          transactionFee.value = _result.result.transactionFee.toString();
          cryptoValue.value = _result.result.cryptoValue.toString();
          /* Prepare for buy */
          amountController.text = _result.result.receivedCoinValue.toString();
          denominatedValue.text = _result.result.cryptoValue.toString();
          cryptoValueController.text =
              _result.result.actualCoinValue.toString();
        }
      } else {
        GlobalVals.errorToast(_result.message);
        settingTextFieldsToZero();
      }
    } else {
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
      settingTextFieldsToZero();
    }
  }

  getBuy(String value, String bodyValue, String apiEndPoint) async {
    isTypeFinished.value = false;
    isRefreshed.value = false;
    /* Get.defaultDialog(
      title: "Loading, Please wait",
      content: CircularProgressIndicator(),
    ); */
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
      bodyValue: value,
    };
    var _response = await http.post(Uri.parse(ApiRoutes.baseUrl + apiEndPoint),
        body: _body, headers: _header);
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      //Get.back();
      if (apiEndPoint == ApiRoutes.getFiatCryptoAmount) {
        var _result =
            BuyValueToAmountModel.fromJson(json.decode(_response.body));
        _logger.d(_result.result.cryptoAmount.toString());
        if (!_result.result.status) {
          isRefreshed.value = false;
          Fluttertoast.showToast(
            msg: _result.result.message,
            backgroundColor: Colors.red,
          );
          settingTextFieldsToZero();
        } else {
          isRefreshed.value = true;
          /* Prepare for buy */
          coinCode.value =
              dashboardValue.cryptoData[index.value].coinName.toLowerCase();
          coinValue.value = value;
          cryptoAmount.value = _result.result.cryptoAmount.toString();
          transactionFeeRate.value =
              _result.result.coinBuyTransactionRate.toString();
          transactionFee.value = _result.result.transactionFee.toString();
          cryptoValue.value = _result.result.actualCoinValue.toString();
          /* Prepare for buy */
          amountController.text = _result.result.cryptoAmount.toString();
          denominatedValue.text = _result.result.actualCoinValue.toString();
        }
      } else {
        var _result =
            BuyAmountToValueModel.fromJson(json.decode(_response.body));
        _logger.d(_result.result.cryptoValue.toString());
        if (!_result.result.status) {
          isRefreshed.value = false;
          Fluttertoast.showToast(
            msg: _result.result.message,
            backgroundColor: Colors.red,
          );
          settingTextFieldsToZero();
        } else {
          isRefreshed.value = true;
          coinCode.value =
              dashboardValue.cryptoData[index.value].coinName.toLowerCase();
          coinValue.value = _result.result.cryptoValue.toString();
          cryptoAmount.value = value;
          transactionFeeRate.value =
              _result.result.coinBuyTransactionRate.toString();
          transactionFee.value = _result.result.transactionFee.toString();
          cryptoValue.value = _result.result.actualCoinValue.toString();

          cryptoValueController.text =
              _result.result.actualCoinValue.toString();
          denominatedValue.text = _result.result.cryptoValue.toString();
        }
      }
      //_box.put(GlobalVals.buyCryptos, _response.body);
    } else {
      isTypeFinished.value = true;
      //Get.back();
      isRefreshed.value = true;
      Fluttertoast.showToast(
          msg: "Server Error. Please try again later.",
          backgroundColor: Colors.red);
      settingTextFieldsToZero();
    }
  }

  settingTextFieldsToZero() {
    amountController.text = "0";
    cryptoValueController.text = "0";
    denominatedValue.text = "0";
  }
}
