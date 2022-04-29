import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/fiat/mode_of_payment_model.dart';
import 'package:masscoinex/models/user_model.dart';

class ModeOfPaymentController extends GetxController {
  var isPaymentLoading = false.obs;
  var _logger = Logger();
  var paymentModeList = <ModeDatum>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPaymentModeList();
  }

  getPaymentModeList() async {
    isPaymentLoading.value = true;
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
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.paymentModeList),
      headers: _header,
    );

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      isPaymentLoading.value = false;
      var _result = modeOfPaymentModelFromJson(_response.body);
      if (_result.code == "1") {
        paymentModeList.value = _result.modeData;
      }
    }
    else{
      isPaymentLoading.value = false;
      GlobalVals.errorToast("Server Error");
    }
  }
}
