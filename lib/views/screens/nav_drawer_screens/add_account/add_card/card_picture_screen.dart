import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NavCardPictureScreen extends StatelessWidget {
  final AddAccountController addAccountController;

  NavCardPictureScreen({Key? key, required this.addAccountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => _cardUpload(
                "Upload (Front Side Card)\n\n",
                " Upload a picture of the front side of your card, please make sure the name printed on the card should be clearly visible and should match the "
                    "name on your profile.  You can hide the expiration date but the card numbers should be clearly readable and visible.\n\n\n",
                null,
                addAccountController.avatar.value,
                "front"),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => _cardUpload(
                "Upload (Selfie with your card)\n\n",
                " Upload a selfie of yourself holding your card, make sure that both your face and the front side of the card are clearly visible and readable. Please don't hide any information on the card except the expiry date.\n\n\n",
                null,
                addAccountController.avatar2.value,
                "back"),
          ),
          SizedBox(
            height: 2.h,
          ),
          _continue(),
        ],
      ),
    );
  }

  Container _cardUpload(String firstText, String secondText, String? thirdText,
      String path, String position) {
    return Container(
      width: double.infinity,
      height: 40.h,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Card(
              elevation: 1.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.h),
              ),
              child: Container(
                height: 38.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.h, right: 4.h),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: firstText,
                            style: TextStyle(
                              color: GlobalVals.backgroundColor,
                              fontSize: 18.sp,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.info,
                              color: Colors.red,
                              size: 2.h,
                            ),
                          ),
                          TextSpan(
                            text: secondText,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15.sp,
                            ),
                          ),
                          thirdText == null
                              ? WidgetSpan(child: SizedBox())
                              : TextSpan(
                                  text: thirdText,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.sp,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Center(
                child: Stack(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          5.h,
                        ),
                        child: Card(
                          elevation: 1.h,
                          shape: CircleBorder(
                            side: BorderSide(
                              width: 0.5.h,
                              color: Colors.white,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                5.h,
                              ),
                              child: _image(position, path),
                            ),
                            radius: 5.h,
                          ),
                        ),
                        onTap: () {
                          position == "front"
                              ? addAccountController.pickImage()
                              : addAccountController.pickImage2();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 1.h,
                      right: 1.h,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(0.4.h),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 2.h,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(String position, String path) {
    if (position == "front") {
      if (addAccountController.isFromAsset.value == true) {
        return Image.asset(
          path,
          fit: BoxFit.cover,
        );
      } else {
        return Image.file(
          File(path),
          fit: BoxFit.cover,
        );
      }
    } else {
      if (addAccountController.isFromAsset2.value == true) {
        return Image.asset(
          path,
          fit: BoxFit.cover,
        );
      } else {
        return Image.file(
          File(path),
          fit: BoxFit.cover,
        );
      }
    }
  }

  Container _continue() {
    return Container(
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
          addAccountController.cardScreenIndex.value = 2;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
