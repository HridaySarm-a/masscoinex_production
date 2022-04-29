import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/checking_user/checking_user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class EmailOtpScreen extends StatelessWidget {
  final isOtpSuccessful = false.obs;
  EmailOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Email OTP"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 7.h,
            ),
            Text(
              "Please enter your OTP to verify your account",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            PinCodeTextField(
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

                final _emailOtp = _success.result!.otp;
                if (v == _emailOtp) {
                  isOtpSuccessful.value = true;
                } else {
                  isOtpSuccessful.value = false;
                  GlobalVals.errorToast("OTP Mismatch");
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.h),
        child: Container(
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
            onPressed: () {
              if (isOtpSuccessful.value == true) {
                Get.toNamed(Routes.pinScreen);
              } else {
                GlobalVals.errorToast(
                  "OTP are not matched",
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: const Text("Submit OTP"),
            ),
          ),
        ),
      ),
    );
  }
}
