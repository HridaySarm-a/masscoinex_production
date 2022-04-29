import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/register_user/register_user_model.dart';
import 'package:masscoinex/routes/route_list.dart';

class RegistrationController extends GetxController {
  var isCheckedCondition = false.obs;
  var isRegistering = false.obs;
  var _logger = Logger();

  registerUser(String fullname, String email, String password, String pin,
      String phone, String country) async {
    isRegistering.value = true;
    var _box = await Hive.openBox(GlobalVals.hiveBox);
    bool _isKyc = _box.get("isKyc");
    final Map<String, dynamic> _body = {
      "full_name": fullname,
      "email": email,
      "password": password,
      "pin": pin,
      "phone": phone,
      "country": country,
      "terms_condition": "1",
      "privacy_policy": "1",
      "aml_kyc": "1",
      "notify": "1",
      "user_type": _isKyc ? "kyc" : "nonkyc",
    };
    var _response = await http
        .post(Uri.parse(ApiRoutes.baseUrl + ApiRoutes.register), body: _body);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isRegistering.value = false;
      var _status = RegisterModel.fromJson(json.decode(_response.body));
      _logger.d(_response.body);
      if (_status.code == "0") {
        var _error = RegisterModel.fromJsonError(json.decode(_response.body));
        GlobalVals.errorToast(_error.registerResultError!.email.first);
      } else {
         var _success =
            RegisterModel.fromJsonSuccess(json.decode(_response.body));
        var _box = await Hive.openBox(GlobalVals.hiveBox);
        _box.put(GlobalVals.register, _response.body);
        _logger.d(_response.body);
        if (_isKyc) {
          _box.put("isComingFromRegistration", true);
          //Get.toNamed(Routes.registrationDetails);
          GlobalVals.successToast(_status.message);
          Get.offAllNamed(Routes.loginEmail);
        } else {
          GlobalVals.successToast(_status.message);
          String _token = _success.registerResult!.token;
          _box.put(GlobalVals.tempToken, _token);
          //Get.toNamed(Routes.selectCurrencyScreenAfterRegistration);
          Get.offAllNamed(Routes.loginEmail);
        }
      }
    } else {
      isRegistering.value = false;
      GlobalVals.errorToast("Server Error");
    }
  }
}
