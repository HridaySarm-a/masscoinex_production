import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';
import 'package:masscoinex/controllers/add_account_controller_new_logic.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardPictureScreenNewLogic extends StatelessWidget {
  final AddAccountControllerNewLogic addAccountController;

  CardPictureScreenNewLogic({Key? key, required this.addAccountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => Column(
              children: [
                _cardUpload(
                    "Upload (Front Side Card)\n\n",
                    " Upload a picture of the front side of your card, please make sure the name printed on the card should be clearly visible and should match the "
                        "name on your profile.  You can hide the expiration date but the card numbers should be clearly readable and visible.\n\n\n",
                    null,
                    addAccountController.avatar.value,
                    "front"),
                addAccountController.isFromAsset.value == true
                    ? SizedBox()
                    : Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.h),
                            child: Image.file(
                              File(addAccountController.avatar.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              addAccountController.pickImage();
                            },
                            child: Text("Select Again"),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => Column(
              children: [
                _cardUpload(
                    "Upload (Selfie with your card)\n\n",
                    " Upload a selfie of yourself holding your card, make sure that both your face and the front side of the card are clearly visible and readable. Please don't hide any information on the card except the expiry date.\n\n\n",
                    null,
                    addAccountController.avatar2.value,
                    "back"),
                addAccountController.isFromAsset2.value == true
                    ? SizedBox()
                    : Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.h),
                            child: Image.file(
                              File(addAccountController.avatar2.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              addAccountController.pickImage2();
                            },
                            child: Text("Select Again"),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => Column(
              children: [
                _cardUpload4(
                  "Upload (Statement with your card)\n\n",
                  "  Please upload the most recent credit card or bank statement linked to the card. Please be advised the statement should not be older than 2 months and it should have all the necessary information of your card and billing details.\n\n\n",
                  null,
                  addAccountController.avatar4.value,
                ),
                addAccountController.isFromAsset4.value == true
                    ? SizedBox()
                    : Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2.h),
                            child: Image.file(
                              File(addAccountController.avatar4.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              addAccountController.pickImage4();
                            },
                            child: Text("Select Again"),
                          ),
                        ],
                      ),
              ],
            ),
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
                child: _image(position, path),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _cardUpload4(
      String firstText, String secondText, String? thirdText, String path) {
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
                child: _image4(path),
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
        return Stack(
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
                      child: Image.asset(
                        path,
                        fit: BoxFit.cover,
                      ),
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
        );
      } else {
        return SizedBox();
      }
    } else {
      if (addAccountController.isFromAsset2.value == true) {
        return Stack(
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
                      child: Image.asset(
                        path,
                        fit: BoxFit.cover,
                      ),
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
        );
      } else {
        return SizedBox();
      }
    }
  }

  Widget _image4(String path) {
    if (addAccountController.isFromAsset4.value == true) {
      return Stack(
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
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  radius: 5.h,
                ),
              ),
              onTap: () {
                addAccountController.pickImage4();
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
      );
    } else {
      return SizedBox();
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
          if (addAccountController.isFromAsset.value ||
              addAccountController.isFromAsset2.value ||
              addAccountController.isFromAsset4.value) {
            Fluttertoast.showToast(
                msg: "Choose both front and back image",
                backgroundColor: Colors.red);
          } else {
            addAccountController.cardScreenIndex.value = 2;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
