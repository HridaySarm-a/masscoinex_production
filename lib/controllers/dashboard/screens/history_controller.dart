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
import 'package:masscoinex/models/fiat/deposit/deposit_model.dart';
import 'package:masscoinex/models/fiat/deposit/fiat_amount_to_deposit_model.dart';
import 'package:masscoinex/models/fiat/fiat_history.dart';
import 'package:masscoinex/models/fiat/withdraw/get_withdraw_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';

class HistoryController extends GetxController {
  /*Typing*/
  var isHistoryRefreshed = true.obs;
  var historyFilter = "".obs;
  var historyList = <Transaction>[].obs;
  final _logger = Logger();
  final _box = Hive.box(GlobalVals.hiveBox);

  var fiatIndex = 0.obs;

  /*Deposit*/
  var hasDepositSaved = true.obs;

  @override
  void onInit() {
    fiatHistory("");
    super.onInit();
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
