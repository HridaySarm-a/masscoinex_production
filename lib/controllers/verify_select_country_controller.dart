import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:masscoinex/models/kyc_upload_model.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/models/user_model.dart';

class VerifySelectCountryController extends GetxController {
  var selectedIndex = 0.obs;
  var _logger = Logger();
  var isSaving = false.obs;
  var kycUploadModel = KycUploadModel().obs;

  setCurrency() async {
    isSaving.value = true;
    var _box = await Hive.openBox(GlobalVals.hiveBox);
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
          kycUploadModel.value.result!.currencydata[selectedIndex.value].currencyCode
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
      Get.back();
    } else {
      isSaving.value = false;
      Fluttertoast.showToast(
          msg: "Something went wrong", backgroundColor: Colors.red);
    }
  }

  @override
  void onInit() async {
    var _box = await Hive.openBox(GlobalVals.hiveBox);
    kycUploadModel.value = kycUploadModelFromJson(_box.get(GlobalVals.kycUploadModel));
    super.onInit();
  }
}
