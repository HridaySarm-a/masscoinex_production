import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/fiat/payments/upi/upi_payment_method_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/deposit_confirmation_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/upi/upi_payment_method_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentModeUpiScreen extends StatelessWidget {
  var _isListLoaded = true.obs;
  var _paymentMethodList = <PaymentMethod>[].obs;
  final _box = Hive.box(GlobalVals.hiveBox);
  final String paymentMethod;
  final _logger = Logger();

  PaymentModeUpiScreen({Key? key, required this.paymentMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getPaymentMethod();
    return Scaffold(
      appBar: AppBar(
        title: Text("UPI Payment"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => _isListLoaded.value == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _paymentMethodList.value.length != 0
                ? ListView.builder(
                    itemCount: _paymentMethodList.value.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.credit_card_outlined),
                        title: Text(_paymentMethodList.value[index].upiName),
                        trailing: Text(
                          _paymentMethodList.value[index].status,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: _paymentMethodList.value[index].status ==
                                    "Active"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        onTap: _paymentMethodList.value[index].status ==
                            "Active" ? () {
                          /* Get.to(
                            DepositConfirmationScreen(
                                paymentMethodId: _paymentMethodList
                                    .value[index].id
                                    .toString(),
                                paymentMethodName:
                                    _paymentMethodList.value[index].upiName),
                          );*/
                          _box.put(GlobalVals.paymentMethodId,
                              _paymentMethodList.value[index].id.toString());
                          _box.put(
                              GlobalVals.paymentMethodName,
                              _paymentMethodList.value[index].upiName
                                  .toString());
                          Get.to(
                            UPIPaymentMethodDetailsScreen(
                              id: _paymentMethodList.value[index].id.toString(),
                            ),
                          );
                        } : null,
                      );
                    },
                  )
                : Center(
                    child: Text("No data to show"),
                  ),
      ),
    );
  }

  _getPaymentMethod() async {
    _isListLoaded.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "payment_mode": paymentMethod,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.paymentMethod),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      _isListLoaded.value = true;
      var _result = upiPaymentMethodModelFromJson(_response.body);
      if (_result.code == "1") {
        _paymentMethodList.value = _result.paymentMethods;
      } else {
        GlobalVals.errorToast("Could not load data");
      }
    } else {
      _isListLoaded.value = true;
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
    }
  }
}
