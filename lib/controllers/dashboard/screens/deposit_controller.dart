import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/deposit_error_model.dart';
import 'package:masscoinex/models/fiat/deposit/deposit_model.dart';
import 'package:masscoinex/models/fiat/deposit/fiat_amount_to_deposit_model.dart';
import 'package:masscoinex/models/fiat/fiat_history.dart';
import 'package:masscoinex/models/fiat/withdraw/get_withdraw_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';

class DepositController extends GetxController {
  /*Api responses*/
  var responseResult = "".obs;
  var isDashboardLoading = false.obs;

  /*Typing*/
  var isTypeFinished = true.obs;
  var isRefreshed = false.obs;
  var isBought = true.obs;
  var isHistoryRefreshed = true.obs;
  var historyFilter = "".obs;
  var historyList = <Transaction>[].obs;
  final _logger = Logger();
  final _box = Hive.box(GlobalVals.hiveBox);

  var fiatIndex = 0.obs;
  var getAmount = "".obs;
  var amountController = TextEditingController(text: "0");
  var currencyController = TextEditingController(text: "");
  var transactionFeeController = TextEditingController(text: "0");
  var transactionFeeRateController = TextEditingController(text: "0");
  var payAmountController = TextEditingController(text: "0");

  /*Deposit*/
  var hasDepositSaved = true.obs;

  @override
  void onInit() {
    getAllDashboard();
    fiatHistory("");
    super.onInit();
  }

  getAllDashboard() async {
    isDashboardLoading.value = true;
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
      _box.put(GlobalVals.dashBoard, _response.body);
      responseResult.value = _response.body;
      var _result = DashboardModel.fromJson(json.decode(_response.body));
      currencyController.text = _result.wallet.currency ?? "";
      /* _logger.d(_response.body);
      _logger.d(_token); */
    } else {
      GlobalVals.errorToast("Server Error");
    }
  }

  insertValue(String amount) async {
    isTypeFinished.value = false;
    isRefreshed.value = false;
    final _userInfo =
    UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "amount": amount,
      "terms": "1",
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getDepositFee),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = fiatAmountToDepositModelFromJson(_response.body);
      if (_result.code == "1") {
        isRefreshed.value = true;
        /*Setting values*/
        amountController.text = amount;
        getAmount.value = amount;
        transactionFeeController.text =
            _result.transcations.transcationFee.toString();
        transactionFeeRateController.text =
            _result.transcations.fiatDepositTransactionRate.toString();
        payAmountController.text = _result.transcations.payAmount.toString();
      } else {
        isTypeFinished.value = true;
        isRefreshed.value = false;
        Fluttertoast.showToast(
          msg: _result.message,
          backgroundColor: Colors.red,
        );
        settingTextFieldsToZero();
      }
    } else if (_response.statusCode == 402) {
      settingTextFieldsToZero();
      isTypeFinished.value = true;
      isRefreshed.value = true;
      var _errorResult = depositErrorModelFromJson(_response.body);
      GlobalVals.errorToast(_errorResult.message);
    }

    else {
      isTypeFinished.value = true;
      settingTextFieldsToZero();
      isRefreshed.value = true;
      Fluttertoast.showToast(
        msg: "Server error: ${_response.statusCode}",
        backgroundColor: Colors.red,
      );
    }
  }

  insertValueWithdraw(String amount) async {
    isTypeFinished.value = false;
    isRefreshed.value = false;
    final _userInfo =
    UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "amount": amount,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getWithdrawFee),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isTypeFinished.value = true;
      var _result = getWithdrawModelFromJson(_response.body);
      if (_result.code == "1") {
        isRefreshed.value = true;
        /*Setting values*/
        amountController.text = amount;
        getAmount.value = amount;
        transactionFeeController.text =
            _result.transcations.transcationFee.toString();
        transactionFeeRateController.text =
            _result.transcations.fiatWithdrawTransactionRate.toString();
        payAmountController.text = _result.transcations.payAmount.toString();
      } else {
        isRefreshed.value = false;
        Fluttertoast.showToast(
          msg: _result.message,
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

  deposit() async {
    hasDepositSaved.value = false;
    final _userInfo =
    UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "amount": getAmount.value,
      "terms": "1",
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.deposit),
        body: _body,
        headers: _header);

    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      hasDepositSaved.value = true;
      var _result = depositModelFromJson(_response.body);
      if (_result.code == "1") {
        _box.put(GlobalVals.deposit, _response.body);
        Get.toNamed(Routes.modeOfPayment);
      }
    } else {
      hasDepositSaved.value = true;
      GlobalVals.errorToast("Error: ${_response.statusCode}");
    }
  }

  settingTextFieldsToZero() {
    amountController.text = "0";
    transactionFeeController.text = "0";
    transactionFeeRateController.text = "0";
    payAmountController.text = "0";
  }

  fiatHistory(String filter) async {
    isHistoryRefreshed.value = false;
    final _userInfo =
    UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "filter": filter,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.fiatTransactionHistory),
        body: _body,
        headers: _header);

    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      isHistoryRefreshed.value = true;
      var _result = fiatHistoryModelFromJson(_response.body);
      if (_result.code == "1") {
        historyList.value = _result.transactions;
      } else {
        Fluttertoast.showToast(
          msg: _result.message,
          backgroundColor: Colors.red,
        );
      }
    } else {
      isHistoryRefreshed.value = true;
      Fluttertoast.showToast(
        msg: "Server error: ${_response.statusCode}",
        backgroundColor: Colors.red,
      );
    }
  }
}
