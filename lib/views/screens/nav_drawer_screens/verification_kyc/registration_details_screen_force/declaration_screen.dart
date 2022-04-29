import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:masscoinex/controllers/nav_kyc/nav_declaration_controller.dart';
import 'package:masscoinex/controllers/nav_kyc/verify_registration_details_controller.dart';
import 'package:masscoinex/controllers/nav_kyc/verify_registration_details_controller_force.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'component/nav_drawer_continue_button.dart';

class VerifyDeclarationScreen extends StatelessWidget {
  final VerifyRegistrationDetailsControllerForce registrationDetailsController;
  final _declarationController = Get.put(DeclarationController());
  final _box = Hive.box(GlobalVals.hiveBox);

  VerifyDeclarationScreen(
      {Key? key, required this.registrationDetailsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat _formatter = DateFormat('dd MMMM yyyy');
    String _createDate = _formatter.format(DateTime.now());
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => SizedBox(
                child: _declarationController.isPicked.value == false
                    ? Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              _declarationController.pickFrontSize();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.blue.shade600,
                              size: 4.h,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.h),
                            child: Text(
                              "Upload selfie with a hand written note of the following declaration",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(2.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 5.h),
                            decoration: BoxDecoration(
                              color: GlobalVals.backgroundColor,
                              borderRadius: BorderRadius.circular(
                                3.h,
                              ),
                            ),
                            child: Column(
                              children: [
                                getDynamicName(),
                                Image.asset(
                                  "assets/signature.png",
                                  color: Colors.white,
                                  width: 35.w,
                                ),
                                Container(
                                  height: 0.1.h,
                                  width: 35.w,
                                  color: Colors.white,
                                ),
                                Text(
                                  _createDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      )
                    : Image.file(
                        File(
                          _declarationController.image.value.path,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(
              () => SizedBox(
                child: registrationDetailsController.isUploaded.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : const SizedBox(),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            NavDrawerKycContinueButton(
              index: 3,
              registrationDetailsController: registrationDetailsController,
              voidCallback: () {
                if (_declarationController.isPicked.value == true) {
                  registrationDetailsController.uploadDeclaration.value =
                      _declarationController.image.value;
                  registrationDetailsController.isDeclarationSelected.value =
                      true;
                } else {
                  registrationDetailsController.isDeclarationSelected.value =
                      false;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Text getDynamicName() {
    final _userModel = UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    return Text(
      "I ${_userModel.result.fullName} registering on Masscoinex.com to buy & sell cryptocurrencies",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Sans",
        fontSize: 14.sp,
      ),
    );
  }
}
