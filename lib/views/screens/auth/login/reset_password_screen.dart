import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/change_password_model.dart';
import 'package:masscoinex/models/reset_model.dart';
import 'package:masscoinex/models/support_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _isPasswordChanged = true.obs;
  final _passwordController = TextEditingController();

  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
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
                  "Enter your valid email address",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        5.h,
                      ),
                      gapPadding: 1.0,
                    ),
                    hintText: "Enter Email",
                    focusColor: Colors.blue,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: 2.h,
                    ),
                  ),
                ),
              ),
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
                      child: _isPasswordChanged.value == false
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Reset Password"),
                    ),
                    onPressed: () {
                      if (_passwordController.text.isEmpty) {
                        GlobalVals.errorToast("Email field can not be empty");
                      } else {
                        _changePassword();
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

  _changePassword() async {
    _isPasswordChanged.value = false;
    final _logger = Logger();
    Map<String, String> _header = {
      'Accept': 'application/json',
    };
    Map<String, String> _body = {
      'email': _passwordController.text,
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.resetPassword),
      headers: _header,
      body: _body,
    );

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      _isPasswordChanged.value = true;
      var _result = ResetModel.fromJson(json.decode(_response.body));
      if (_result.result == "You are not active yet!") {
        GlobalVals.errorToast(_result.result);
      } else if (_result.result == "Email is not registered!") {
        GlobalVals.errorToast(_result.result);
      } else {
        Fluttertoast.showToast(msg: _result.result);
        Get.back();
      }
    } else {
      _isPasswordChanged.value = true;
      GlobalVals.errorToast("No Email Found");
    }
  }
}
