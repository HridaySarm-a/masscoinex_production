import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/reset_pin_model.dart';
import 'package:masscoinex/models/support_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ChangePinScreen extends StatelessWidget {
  final _isPinChanged = true.obs;
  final _pinController = TextEditingController();
  final _pinControllerConfirm = TextEditingController();

  ChangePinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Pin",
        ),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.h,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Enter your new pin to change",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              _pins(),
              SizedBox(
                height: 3.h,
              ),
              Obx(() {
                return SizedBox(
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: _isPinChanged.value == false
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Change Pin"),
                    ),
                    onPressed: () {
                      if (_pinController.text.isEmpty ||
                          _pinControllerConfirm.text.isEmpty) {
                        GlobalVals.errorToast("Input fields can not be empty");
                      } else if (_pinController.text !=
                          _pinControllerConfirm.text) {
                        GlobalVals.errorToast("Pin Mismatch");
                      } else if ((_pinController.text.length < 6) ||
                          (_pinControllerConfirm.text.length < 6)) {
                        GlobalVals.errorToast(
                            "Pins can not be less than 6 digit");
                      } else {
                        _changePin();
                      }
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  _changePin() async {
    _isPinChanged.value = false;
    final _logger = Logger();
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    Map<String, String> _body = {
      'pin': _pinController.text,
      'pin_confirmation': _pinController.text,
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.resetPin),
      headers: _header,
      body: _body,
    );

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      _isPinChanged.value = true;
      var _result = ResetPinModel.fromJson(json.decode(_response.body));
      GlobalVals.successToast(_result.result);
      Get.back();
    } else {
      _isPinChanged.value = true;
      GlobalVals.errorToast("Error: ${_response.statusCode}");
    }
  }

  Widget _pins() {
    return Column(
      children: [
        TextField(
          maxLength: 6,
          keyboardType: TextInputType.number,
          controller: _pinController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                5.h,
              ),
              gapPadding: 1.0,
            ),
            hintText: "Set 6 digit PIN",
            focusColor: Colors.blue,
            contentPadding: EdgeInsets.symmetric(
              vertical: 1.h,
              horizontal: 2.h,
            ),
          ),
        ),
        SizedBox(
          width: 5.h,
        ),
        TextField(
          maxLength: 6,
          keyboardType: TextInputType.number,
          controller: _pinControllerConfirm,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                5.h,
              ),
              gapPadding: 1.0,
            ),
            hintText: "Confirm 6 digit PIN",
            focusColor: Colors.blue,
            contentPadding: EdgeInsets.symmetric(
              vertical: 1.h,
              horizontal: 2.h,
            ),
          ),
        ),
      ],
    );
  }
}
