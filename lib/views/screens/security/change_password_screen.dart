import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/change_password_model.dart';
import 'package:masscoinex/models/support_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _isPasswordChanged = true.obs;
  final _passwordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _passwordControllerConfirm = TextEditingController();
  final _passwordControllerObscure = true.obs;
  final _oldPasswordControllerObscure = true.obs;
  final _passwordControllerConfirmObscure = true.obs;

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
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
                  "Enter your new password to change",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              _passwords(),
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
                          : const Text("Change Password"),
                    ),
                    onPressed: () {
                      if (_passwordController.text.isEmpty ||
                          _passwordControllerConfirm.text.isEmpty ||
                          _oldPasswordController.text.isEmpty) {
                        GlobalVals.errorToast("Input fields can not be empty");
                      } else if (_passwordController.text !=
                          _passwordControllerConfirm.text) {
                        GlobalVals.errorToast("Password Mismatch");
                      } else if ((_passwordController.text.length < 8) ||
                          (_passwordControllerConfirm.text.length < 8) ||
                          (_oldPasswordController.text.length < 8)) {
                        GlobalVals.errorToast(
                            "Passwords can not be less than 8 digit");
                      } else if (!validateStructure(_passwordController.text)) {
                        GlobalVals.errorToast(
                            "Password must contain\nMinimum 1 Upper case\n Minimum 1 lowercase \n Minimum 1 Numeric Number\n Minimum 1 Special Character\nCommon Allow Character ( ! @ # \$ & * ~ )");
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
      'old_password': _oldPasswordController.text,
      'new_password': _passwordController.text,
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.changePassword),
      headers: _header,
      body: _body,
    );

    _logger.d(_response.body);

    if (_response.statusCode == 200) {
      _isPasswordChanged.value = true;
      var _result = ChangePasswordModel.fromJson(json.decode(_response.body));
      if (_result.result == "Old password does not match") {
        GlobalVals.errorToast("Old password does not match");
      }
      else{
        Fluttertoast.showToast(msg: _result.result);
        Get.back();
      }
      //Get.back();
    } else {
      _isPasswordChanged.value = true;
      GlobalVals.errorToast("Error: ${_response.statusCode}");
    }
  }

  Widget _passwords() {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: TextField(
              controller: _oldPasswordController,
              obscureText: _oldPasswordControllerObscure.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _oldPasswordControllerObscure.value =
                    !_oldPasswordControllerObscure.value;
                  },
                  icon: Icon(
                    _oldPasswordControllerObscure.value == true
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                  gapPadding: 1.0,
                ),
                hintText: "Enter Old Password",
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  horizontal: 2.h,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: TextField(
              controller: _passwordController,
              obscureText: _passwordControllerObscure.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _passwordControllerObscure.value =
                    !_passwordControllerObscure.value;
                  },
                  icon: Icon(
                    _passwordControllerObscure.value == true
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                  gapPadding: 1.0,
                ),
                hintText: "New Password",
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  horizontal: 2.h,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: TextField(
              controller: _passwordControllerConfirm,
              obscureText: _passwordControllerConfirmObscure.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _passwordControllerConfirmObscure.value =
                    !_passwordControllerConfirmObscure.value;
                  },
                  icon: Icon(
                    _passwordControllerConfirmObscure.value == true
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                  gapPadding: 1.0,
                ),
                hintText: "Confirm Password",
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  horizontal: 2.h,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
