import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/fiat/payments/card/card_payment_method_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/card/card_payment_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentModeCardScreen extends StatefulWidget {
  final String paymentMethod;

  PaymentModeCardScreen({Key? key, required this.paymentMethod})
      : super(key: key);

  @override
  State<PaymentModeCardScreen> createState() => _PaymentModeCardScreenState();
}

class _PaymentModeCardScreenState extends State<PaymentModeCardScreen> {
  final _isListLoaded = true.obs;

  final _paymentMethodList = <PaymentMethod>[].obs;

  final _box = Hive.box(GlobalVals.hiveBox);

  final _logger = Logger();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getPaymentMethod();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Card Payment"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => _isListLoaded.value == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _paymentMethodList.value.length != 0
                ? buildListView()
                : Center(
                    child: Text("No data to show"),
                  ),
      ),
    );
  }

  Widget buildListView() {
    if (!_isLoading) {
      return ListView.builder(
        itemCount: _paymentMethodList.value.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration( //                    <-- BoxDecoration
                border: Border(bottom: BorderSide()),
              ),
              child: ListTile(
                leading: Icon(Icons.credit_card_outlined),
                title: Text(_paymentMethodList.value[index].name),
                trailing: Text(
                  _paymentMethodList.value[index].status,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: _paymentMethodList.value[index].status == "Active"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                onTap: _paymentMethodList.value[index].status == "Active"
                    ? () {
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
                        _box.put(GlobalVals.paymentMethodName,
                            _paymentMethodList.value[index].name.toString());
                        _checkUserData(
                            _paymentMethodList.value[index].id.toString(),
                            _paymentMethodList.value[index].name.toString());
                      }
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: CircularProgressIndicator(),
        ),
      );
    }
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
      "payment_mode": widget.paymentMethod,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.paymentMethod),
        body: _body,
        headers: _header);

    _logger.d(_response.body.toString());

    if (_response.statusCode == 200) {
      _isListLoaded.value = true;
      var _result = cardPaymentMethodModelFromJson(_response.body);
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

  _checkUserData(String id, String name) async {
    setState(() {
      _isLoading = true;
    });
    final _userInfo = UserModel.fromJson(jsonDecode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    Map<String, String> _body = {
      'Accept': 'application/json',
      'payment_mode': 'card',
      'amount': '500',
      'payment_method_id': id,
      'payment_method_name': name
    };

    final response = await http.post(
        Uri.parse('https://test.masscoinex.com/api/deposit-confirmation'),
        headers: _header,
        body: _body);

    _logger.d(response.body.toString());
    if (response.statusCode == 200) {
      if (response.body.toString() != "") {
        var data = jsonDecode(response.body.toString());
        if (data['code'] == "1") {
          Get.to(
            CardPaymentScreen(
              paymentMode: "card",
            ),
          );
        }else{
          setState(() {
            _isLoading = false;
          });
          GlobalVals.errorToast("Please add card to continue");
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        GlobalVals.errorToast("Please add card to continue");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      GlobalVals.errorToast("Please add card to continue");
    }
  }
}
