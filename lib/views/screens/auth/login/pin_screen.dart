import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/controllers/login/pin_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/checking_user/checking_user_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PinScreen extends StatelessWidget {
  final _isPinSuccessful = false.obs;
  final _attempts = 3.obs;
  final _pinController = Get.put(PinController());
  PinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your PIN"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Please enter your PIN to verify your account",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(
              () => AbsorbPointer(
                absorbing: _attempts.value == 0,
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 7.h,
                    fieldWidth: 14.w,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.grey.shade300,
                    selectedColor: Colors.blue,
                    selectedFillColor: Colors.white,
                    activeColor: Colors.blue,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) async {
                    final _box = await Hive.openBox(GlobalVals.hiveBox);
                    final _success = CheckUserModel.fromJsonSuccess(
                        json.decode(_box.get(GlobalVals.checkLogin)));
                    final _pin = _success.result!.pin;
                    if (v == _pin) {
                      _isPinSuccessful.value = true;
                    } else {
                      _isPinSuccessful.value = false;
                    }
                    print("Completed $v");
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () => Text(
                    "${_attempts.value.toString()} _attempts remaining",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Forgot PIN??");
                  },
                  child: Text(
                    "Forgot PIN?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.h),
        child: Container(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
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
              onPressed: () {
                if (_isPinSuccessful.value == false) {
                  if (_attempts.value > 0) {
                    _attempts.value = _attempts.value - 1;
                    GlobalVals.errorToast("Pin Mismatch");
                  }
                } else {
                  _attempts.value = 3;
                  _pinController.loginUser();
                  //176830
                  //!More to do
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: _pinController.isLoggingLoading.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Submit PIN"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
