import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/checking_user/checking_user_model.dart';
import 'package:masscoinex/routes/route_list.dart';

class LoginControllerEmail extends GetxController {
  var isCheckedCondition = false.obs;
  var isLoggingLoading = false.obs;
  var typedPassword = "".obs;
  final _logger = Logger();

  checkUserCredentials(String email, String password) async {
    _logger.d("This Api Called");
    isLoggingLoading.value = true;
    final Map<String, dynamic> _body = {"email": email, "password": password};
    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.checkingUser),
        body: _body);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isLoggingLoading.value = false;
      var _checkingUser = CheckUserModel.fromJson(json.decode(_response.body));
      _logger.d(_response.body);
      if (_checkingUser.code == "0") {
        var _error = CheckUserModel.fromJsonError(json.decode(_response.body));
        GlobalVals.errorToast(_error.resultError!.error);
        /* Fluttertoast.showToast(
            msg: _error.resultError!.error,
            backgroundColor: Colors.red,
            textColor: Colors.white); */
      } else {
        var _box = await Hive.openBox(GlobalVals.hiveBox);
        _box.put(GlobalVals.checkLogin, _response.body);
        _logger.d(_response.body);
        Get.toNamed(Routes.emailVerification);
      }
    } else {
      isLoggingLoading.value = false;
      GlobalVals.errorToast(
        "Server Error",
      );
      /* Fluttertoast.showToast(
          msg: "Server Error",
          backgroundColor: Colors.red,
          textColor: Colors.white); */
    }
  }
}
