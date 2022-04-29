import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/nav_kyc/nav_selfie_id_controller.dart';
import 'package:masscoinex/controllers/nav_kyc/verify_registration_details_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'component/nav_drawer_continue_button.dart';

class VerifySelfieIdScreen extends StatelessWidget {
  final VerifyRegistrationDetailsController registrationDetailsController;
  final _selfieIdScreen = Get.put(SelfieIdController());
  VerifySelfieIdScreen({Key? key, required this.registrationDetailsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Obx(
                  () => SizedBox(
                    child: _selfieIdScreen.isPicked.value == false
                        ? Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _selfieIdScreen.pickFrontSize();
                                  //Fluttertoast.showToast(msg: "Upload");
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
                              Text("Upload selfie with ID proof"),
                              SizedBox(
                                height: 40.h,
                              ),
                            ],
                          )
                        : Image.file(
                            File(
                              _selfieIdScreen.image.value.path,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                )
              ],
            ),
            NavDrawerKycContinueButton(
              index: 1,
              registrationDetailsController: registrationDetailsController,
              voidCallback: () {
                if (_selfieIdScreen.isPicked.value == true) {
                  registrationDetailsController.uploadSelfieID.value =
                      _selfieIdScreen.image.value;
                  registrationDetailsController.isSelfieWithIdSelected.value =
                      true;
                } else {
                  registrationDetailsController.isSelfieWithIdSelected.value =
                      false;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
