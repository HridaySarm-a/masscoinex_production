import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/checking_user/checking_user_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';

class PinController extends GetxController {
  var isLoggingLoading = false.obs;
  final _logger = Logger();

  loginUser() async {
    isLoggingLoading.value = true;
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _success = CheckUserModel.fromJsonSuccess(
        json.decode(_box.get(GlobalVals.checkLogin)));
    final Map<String, dynamic> _body = {
      "email": _success.result!.email,
      "password": _success.result!.password,
      "verfiedOtp": "1",
      "verfiedPin": "1"
    };
    var _response = await http
        .post(Uri.parse(ApiRoutes.baseUrl + ApiRoutes.login), body: _body);

    if (_response.statusCode == 200) {
      final _loginUser = UserModel.fromJson(json.decode(_response.body));
      _logger.d(_response.body);
      if (_loginUser.code == "1") {
        if (_loginUser.result.employeeStatus == "active") {
          _box.put(GlobalVals.user, _response.body);
          _box.put(GlobalVals.isLoggedIn, true);
          getProfileInfo();
        } else {
          GlobalVals.errorToast("Your account is not active");
        }
        /* GetStorage box = GetStorage();
        box.write("loggedIn", true); */
      } else {
        GlobalVals.errorToast("Not logged in");
      }
    } else {
      isLoggingLoading.value = false;
      GlobalVals.errorToast(
        "Server Error",
      );
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
      isLoggingLoading.value = false;
      Fluttertoast.showToast(
        msg: "Successfully logged in",
        backgroundColor: Colors.green,
      );
      _box
          .put(GlobalVals.profileInfo, _response.body)
          .then((value) => Get.offAllNamed(Routes.mainScreenCopy));
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
}
