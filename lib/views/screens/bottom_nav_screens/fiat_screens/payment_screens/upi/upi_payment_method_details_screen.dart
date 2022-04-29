import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/fiat/payments/upi/upi_payment_method_details_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/deposit_confirmation_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';

class UPIPaymentMethodDetailsScreen extends StatelessWidget {
  var _upiId = "".obs;
  var _imageUrl = "".obs;
  var _isListLoaded = true.obs;
  final _box = Hive.box(GlobalVals.hiveBox);
  var _logger = Logger();

  //var _paymentMethodList = <ModeDataField>[].obs;
  var _referenceCodeController = TextEditingController();
  final String id;

  UPIPaymentMethodDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getDetails();
    return Scaffold(
      appBar: AppBar(
        title: Text("UPI Payment"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => _isListLoaded.value == true
            ? _upiInfo()
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: _continue("Continue", () {
        _box.put(GlobalVals.referenceNo, _referenceCodeController.text);
        Get.to(
          DepositConfirmationScreen(
            paymentMode: "upi",
          ),
        );
      }),
    );
  }

  Widget _upiInfo() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              "assets/upi.jpg",
              height: 15.h,
              width: 30.w,
            ),
            CachedNetworkImage(
              imageUrl: _imageUrl.value,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => Image.asset(
                "assets/barcode.jpg",
                height: 10.h,
                width: 30.w,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _upiId.value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FlutterClipboard.copy(_upiId.value).then((value) {
                      _logger.d("Copied");
                    });
                  },
                  child: Text(
                    "copy",
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Reference no: 000679",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "copy",
                    style: TextStyle(),
                  ),
                ),
              ],
            ),*/
            Text(
              "Scan & pay",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 71.w,
              height: 0.1.h,
              color: Colors.black,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Add your UPI transaction reference no below not the avobe displayed",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.all(3.h),
              height: 4.h,
              width: double.infinity,
              child: TextField(
                controller: _referenceCodeController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.h,
                    ),
                    gapPadding: 1.0,
                  ),
                  hintText: "Enter the reference number",
                  focusColor: Colors.blue,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 1.h,
                    horizontal: 2.h,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _continue(String text, VoidCallback voidCallback) {
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
          child: Text(text),
        ),
      ),
    );
  }

  _getDetails() async {
    _isListLoaded.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "payment_mode": "upi",
      "payment_method_id": id,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.paymentMethodDetails),
        body: _body,
        headers: _header);

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      _isListLoaded.value = true;
      var _result = upiPaymentMethodDetailsModelFromJson(_response.body);
      if (_result.code == "1") {
        if (_result.modeDataFields.length != 0) {
          _upiId.value = _result.modeDataFields.first.fieldValue;
          _imageUrl.value = _result.modeDataFields.last.fieldValue;
        } else {
          _upiId.value = "";
          _imageUrl.value = "";
        }
      }
      else{
        GlobalVals.errorToast("Error Getting Data");
      }
    } else {
      _isListLoaded.value = true;
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
    }
  }
}
