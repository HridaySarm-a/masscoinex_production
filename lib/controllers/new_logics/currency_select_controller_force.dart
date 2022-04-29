import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:masscoinex/models/currency_select_model.dart';
import 'package:masscoinex/models/kyc_upload_model.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/models/register_user/register_user_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';

class CurrencySelectControllerNewLogicForce extends GetxController {
  var selectedIndex = 0.obs;
  var _logger = Logger();
  var isSaving = false.obs;
  var currencySelectList = <CurrencyResult>[].obs;
  var _box = Hive.box(GlobalVals.hiveBox);
  var isCurrencyLoaded = true.obs;

  _getCurrency() async {
    isCurrencyLoaded.value = false;
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.currencyList),
      headers: _header,
    );
    _logger.d("Response: ${_response.body}");
    if (_response.statusCode == 200) {
      isCurrencyLoaded.value = true;
      var _result = currencySelectModelFromJson(_response.body);
      if (_result.code == "1") {
        currencySelectList.value = _result.result;
      } else {
        GlobalVals.errorToast(_result.message);
      }
    } else {
      isCurrencyLoaded.value = true;
      Fluttertoast.showToast(
          msg: "Something went wrong", backgroundColor: Colors.red);
    }
  }

  setCurrency() async {
    isSaving.value = true;
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d('Bearer $_token');

    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "currency_symbol":
          currencySelectList.value[selectedIndex.value].currencyCode
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.currencySetup),
      headers: _header,
      body: _body,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      isSaving.value = false;
      Fluttertoast.showToast(
          msg: "Successfully saved", backgroundColor: Colors.green);
      Get.offAllNamed(Routes.addCardNewLogicForce);
      print('Its here to select currency. HHHHHHHHHHHHHHHHHHH');
      // getProfileInfo();
    } else {
      isSaving.value = false;
      Fluttertoast.showToast(
          msg: "Something went wrong", backgroundColor: Colors.red);
    }
  }

  getProfileInfo() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.profileInfo),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      _box.put(GlobalVals.profileInfo, _response.body).then((value) {
        //Get.offAllNamed(Routes.mainScreenCopy)
        isSaving.value = false;
        Fluttertoast.showToast(
            msg: "Successfully saved", backgroundColor: Colors.green);
        Get.offAllNamed(Routes.mainScreenCopy);
      });
      //Get.offAllNamed(Routes.mainScreenCopy);
      //responseResult.value = _response.body;
      // var _result = DashboardModel.fromJson(json.decode(_response.body));
      //resultLength.value = _result.cryptoData.length;
      /*
      _logger.d(_token); */
    } else {
      //Get.offAllNamed(Routes.mainScreen);
      GlobalVals.errorToast("Server Error");
    }
  }

  @override
  void onInit() {
    _getCurrency();
    /*kycUploadModel.value =
        kycUploadModelFromJson(_box.get(GlobalVals.kycUploadModel));*/
    super.onInit();
  }
}
