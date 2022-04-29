import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/nav_kyc/verify_registration_details_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NavDrawerKycContinueButton extends StatelessWidget {
  final int index;
  final VerifyRegistrationDetailsController registrationDetailsController;
  final VoidCallback voidCallback;
  final _logger = Logger();
  NavDrawerKycContinueButton({
    Key? key,
    required this.index,
    required this.registrationDetailsController,
    required this.voidCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Future.delayed(Duration(microseconds: 1), voidCallback);
          Future.delayed(Duration(microseconds: 2), () {
            if (registrationDetailsController.currentIndex.value < 3) {
              registrationDetailsController.currentIndex.value++;
            } else if (registrationDetailsController.currentIndex.value == 3) {
              if (registrationDetailsController.isFrontAndBackSelected.value != true ||
                  registrationDetailsController.isSelfieWithIdSelected.value !=
                      true ||
                  registrationDetailsController.isSelfieSelected.value !=
                      true ||
                  registrationDetailsController.isDeclarationSelected.value !=
                      true) {
                _logger.e(
                    "Front and back ${registrationDetailsController.isFrontAndBackSelected.value} and selfie with id ${registrationDetailsController.isSelfieSelected.value} and selfie ${registrationDetailsController.isSelfieSelected.value} and declaration ${registrationDetailsController.isDeclarationSelected.value}");
                Fluttertoast.showToast(
                  msg: "One of the image is not selected/captured",
                  backgroundColor: Colors.red,
                );
              } else {
                _logger.d("Proceed");
                registrationDetailsController.uploadImagesToKyc();
                //Get.offNamed(Routes.verifyKycUpload);
              }
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
