import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/currency/buy/buy_history_model.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;

class TransactionHistoryController extends GetxController {
  late DashboardModel dashboardValue;
  var index = 0.obs;
  var _dashboardString = "".obs;
  final _box = Hive.box(GlobalVals.hiveBox);
  var coinCode = "bitcoin".obs;
  var filter = "Buy".obs;
  var isHistoryUpdated = true.obs;
  final _logger = Logger();

  /* values */
  var coinImage = "".obs;
  var coinSymbol = "".obs;
  var coinName = "".obs;

  var historyList = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    _dashboardString.value = _box.get(GlobalVals.dashBoard);
    dashboardValue =
        DashboardModel.fromJson(json.decode(_dashboardString.value));
    coinCode.value =
        dashboardValue.cryptoData[index.value].coinName.toLowerCase();
    coinImage.value = dashboardValue.cryptoData[index.value].coinImage;
    //getHistory();
  }

  getHistory(var index) async {
    historyList.value = <Transaction>[];
    isHistoryUpdated.value = false;
    coinCode.value = dashboardValue.cryptoData[index].coinName.toLowerCase();
    _logger.d(coinCode.value);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "coin_code": coinCode.value,
      "filter": filter.value,
    };
    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.history),
        body: _body,
        headers: _header);

    if (_response.statusCode == 200) {
      isHistoryUpdated.value = true;
      var _result = buyHistoryModelFromJson(_response.body);
      if (_result.code == "1") {
        //coinImage.value = _result.cryptoData.first.coinImage;
        coinSymbol.value = _result.cryptoData.first.coinSymbol.toString().toUpperCase();
        coinName.value = _result.cryptoData.first.coinName;
        historyList.value = _result.transactions;
      } else {
        Fluttertoast.showToast(
          msg: _result.message,
          backgroundColor: Colors.red,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: _response.statusCode.toString(),
        backgroundColor: Colors.red,
      );
      isHistoryUpdated.value = true;
    }
  }
}
