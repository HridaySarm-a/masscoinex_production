import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/controllers/mobile_verification_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/register_user/register_user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class MobileVerificationRegistrationScreen extends StatelessWidget {
  final _box = Hive.box(GlobalVals.hiveBox);
  final _otpController = TextEditingController();
  final MobileVerificationController _mobileVerificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _success = RegisterModel.fromJsonSuccess(
        json.decode(_box.get(GlobalVals.register)));
    Future.delayed(Duration(milliseconds: 1), () {
      _mobileVerificationController.countdownController.start();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Verification Code"),
        backgroundColor: GlobalVals.backgroundColor,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 3.h,
            vertical: 5.h,
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/otp.svg",
                  height: 10.h,
                  width: 5.h,
                  color: GlobalVals.buttonColor,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Please enter the verification code sent to",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  _success.registerResult!.phone,
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: _otpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        5.h,
                      ),
                      gapPadding: 1.0,
                    ),
                    hintText: "Verification Code",
                    focusColor: Colors.blue,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: 2.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Didn't get the code?",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "When the timer ends, tap ",
                      ),
                      TextSpan(
                        text: "Resend OTP",
                        style: TextStyle(
                          color: _mobileVerificationController
                                      .isCountdownEnded.value ==
                                  true
                              ? Colors.blue.shade600
                              : Colors.grey,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (_mobileVerificationController
                                    .isCountdownEnded.value ==
                                true) {
                              print("Resend otp");
                              _mobileVerificationController
                                  .isCountdownEnded.value = false;
                              _mobileVerificationController.countdownController
                                  .restart();
                            }
                          },
                      ),
                      TextSpan(
                        text: " to send the OTP again.",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Stack(
                  children: [
                    CircularCountDownTimer(
                      duration: 60,
                      initialDuration: 0,
                      controller:
                          _mobileVerificationController.countdownController,
                      width: 15.h,
                      height: 15.h,
                      ringColor: Colors.grey.shade300,
                      fillColor: Colors.blue,
                      backgroundColor: Colors.white,
                      strokeWidth: 0.4.h,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 33.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.S,
                      isReverse: true,
                      isReverseAnimation: true,
                      isTimerTextShown: true,
                      autoStart: false,
                      onStart: () {
                        print('Countdown Started');
                      },
                      onComplete: () {
                        print('Countdown Ended');
                        _mobileVerificationController.isCountdownEnded.value =
                            true;
                      },
                    ),
                    Positioned(
                      top: 9.5.h,
                      bottom: 0,
                      left: 6.h,
                      right: 0,
                      child: Text(
                        "sec",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
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
                      //Get.toNamed(Routes.emailVerificationRegistration);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text("Verify"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
