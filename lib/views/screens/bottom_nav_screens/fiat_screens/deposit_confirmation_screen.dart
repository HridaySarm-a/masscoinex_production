import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:get/get.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/fiat/deposit/deposit_model.dart';
import 'package:masscoinex/models/fiat/payments/save_deposit_model.dart';
import 'package:masscoinex/models/fiat/payments/upi/upi_deposit_confirmation_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:masscoinex/routes/route_list.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/webview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DepositConfirmationScreen extends StatelessWidget {
  var _isListLoaded = true.obs;
  final _box = Hive.box(GlobalVals.hiveBox);
  var _userDataList = <UserDatum>[].obs;
  var _logger = Logger();
  var _amount = "".obs;
  var _paymentMethodId = "".obs;
  var _paymentMethodName = "".obs;
  var _transactionNo = "".obs;
  var _referenceNo = "".obs;
  var _selectedIndex = 0.obs;
  var _depositFeeController = TextEditingController();
  var _depositAmountController = TextEditingController();
  var _amountController = TextEditingController();
  var _currencyController = TextEditingController();
  var _isButtonActive = false.obs;
  var _isDepositSaved = true.obs;
  var _id = "".obs;
  final String paymentMode;

  DepositConfirmationScreen({Key? key, required this.paymentMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _whichDataToLoad();
    return Scaffold(
      appBar: AppBar(
        title: Text("Deposit Confirmation"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => _isListLoaded.value == true
            ? _upiView()
            : const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: Obx(() {
        return _continue(
            "Continue",
            _isButtonActive.value == false
                ? null
                : () {
                    _saveDeposit();
                  });
      }),
    );
  }

  Widget _upiView() {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              _converter(),
              SizedBox(
                height: 2.h,
              ),
              _cryptoValueConvt(),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _userDataList.value.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return ListTile(
                      subtitle: Text(
                        _userDataList.value[index].upiCodeName,
                      ),
                      title: Text(
                        _userDataList.value[index].upiCode ?? "UPI",
                      ),
                      selected: _selectedIndex.value == index ? true : false,
                      selectedTileColor: Colors.grey.shade200,
                      onTap: () {
                        _id.value = _userDataList.value[index].id.toString();
                        _selectedIndex.value = index;
                      },
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _continue(String text, VoidCallback? voidCallback) {
    return Container(
      padding: EdgeInsets.all(3.h),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            GlobalVals.buttonColor,
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                5.h,
              ),
            ),
          ),
        ),
        onPressed: voidCallback,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: _isDepositSaved.value == true
              ? Text(text)
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  Row _converter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: _amountAndCurrency(
            CrossAxisAlignment.start,
            "Amount to Deposit",
            TextAlign.start,
            _amountController,
            null,
            "",
            false,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(top: 3.h),
            child: Icon(
              Icons.shuffle,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _amountAndCurrency2(
            CrossAxisAlignment.end,
            "Currency",
            TextAlign.end,
            _currencyController,
            "",
            null,
            false,
          ),
        ),
      ],
    );
  }

  Widget _amountAndCurrency2(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextAlign textAlign,
      TextEditingController textEditingController,
      String? prefixText,
      String? suffixTest,
      bool isEnabled) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(1.h),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: TextField(
            enabled: isEnabled,
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
              prefix: prefixText != null ? Text(prefixText) : SizedBox(),
              suffix: suffixTest != null ? Text(suffixTest) : SizedBox(),
              hintText: "Enter Amount",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _amountAndCurrency(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextAlign textAlign,
      TextEditingController textEditingController,
      String? prefixText,
      String? suffixTest,
      bool isEnabled) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(1.h),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: TextField(
            enabled: isEnabled,
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
              prefix: prefixText != null ? Text(prefixText) : SizedBox(),
              suffix: suffixTest != null ? Text(suffixTest) : SizedBox(),
              hintText: "Enter Amount",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _cryptoValueConvt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: _cryptoValue(
            CrossAxisAlignment.start,
            "Deposit Fee",
            _depositFeeController,
            BorderRadius.circular(1.h),
            Colors.grey.shade200,
            TextAlign.start,
            null,
            "",
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 1,
          child: _cryptoValue(
            CrossAxisAlignment.end,
            "Deposit Amount",
            _depositAmountController,
            BorderRadius.circular(1.h),
            Colors.grey.shade200,
            TextAlign.end,
            "",
            null,
          ),
        ),
      ],
    );
  }

  Column _cryptoValue(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextEditingController textEditingController,
      BorderRadius borderRadius,
      Color color,
      TextAlign textAlign,
      String? prefixText,
      String? suffixTest) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: TextField(
            enabled: false,
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
              prefix: prefixText != null ? Text(prefixText) : SizedBox(),
              suffix: suffixTest != null ? Text(suffixTest) : SizedBox(),
              hintText: "Enter Crypto Value",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _whichDataToLoad() {
    if (paymentMode == "upi") {
      //Upi
      _getDepositInfoForUpi();
    } else if (paymentMode == "card") {
      //Card
    } else {
      //Bank
    }
  }

  _saveDeposit() async {
    _isDepositSaved.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "amount": _amount.value,
      "payment_mode": paymentMode,
      "payment_method_id": _paymentMethodId.value,
      "payment_method_name": _paymentMethodName.value,
      "transaction_no": _transactionNo.value,
      "reference_no": _referenceNo.value,
      "id": _id.value,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.saveDeposit),
        body: _body,
        headers: _header);
    _logger.d("Deposit Info: ${_response.body}");

    if (_response.statusCode == 200) {
      _isDepositSaved.value = true;
      var _result = saveDepositModelFromJson(_response.body);
      if (_result.code == "1") {
        GlobalVals.successToast("Successfully Deposited");
        if (_result.loginUrl != null) {
          Get.to(WebViewExample(url: _result.loginUrl));
        } else {
          Get.offAllNamed(Routes.mainScreenCopy);
        }
      } else {
        GlobalVals.errorToast("Error Occurred");
      }
    } else {
      _isDepositSaved.value = true;
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
    }
  }

  _getDepositInfoForUpi() async {
    _isListLoaded.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _depositInfo = depositModelFromJson(_box.get(GlobalVals.deposit));
    final _dashboard =
        DashboardModel.fromJson(json.decode(_box.get(GlobalVals.dashBoard)));
    _paymentMethodId.value = _box.get(GlobalVals.paymentMethodId);
    _paymentMethodName.value = _box.get(GlobalVals.paymentMethodName);
    _referenceNo.value = _box.get(GlobalVals.referenceNo);
    _amount.value = _depositInfo.amount;
    final _token = _userInfo.result.token;
    //final _token = GlobalVals.defaultToken;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "payment_mode": "upi",
      "amount": _depositInfo.amount,
      "payment_method_id": _paymentMethodId.value,
      "payment_method_name": _paymentMethodName.value,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.depositConfirmation),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      _isListLoaded.value = true;
      var _result = upiDepositConfirmationModelFromJson(_response.body);
      if (_result.code == "1") {
        _isButtonActive.value = true;
        _userDataList.value = _result.userData;
        _depositFeeController.text = _result.depositFee.toString();
        _depositAmountController.text = _result.depositAmount.toString();
        _amountController.text = _depositInfo.amount;
        _currencyController.text = _dashboard.wallet.currency ?? "";
        _transactionNo.value = _result.transactionNo;
      } else {
        GlobalVals.errorToast("Fetch Error");
      }
    } else {
      _isListLoaded.value = true;
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
    }
  }
}
