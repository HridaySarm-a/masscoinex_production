import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';
import 'package:masscoinex/controllers/add_account_controller_new_logic_force.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardFieldsScreenNewLogicForce extends StatelessWidget {
  final AddAccountControllerNewLogicForce addAccountController;

  const CardFieldsScreenNewLogicForce({Key? key, required this.addAccountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _textFields("Name on Card", addAccountController.nameOnCardController,
              TextInputType.name),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: double.infinity,
            height: 17.h,
            child: TextField(
              controller: addAccountController.billingAddressController,
              keyboardType: TextInputType.text,
              maxLines: 2,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    3.h,
                  ),
                  gapPadding: 1.0,
                ),
                hintText: "Billing Address",
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 5.h,
                ),
              ),
            ),
          ),
          _textFields(
              "Telephone Number",
              addAccountController.telephoneNumberController,
              TextInputType.number),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Country", addAccountController.countryController,
              TextInputType.name),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Card Number", addAccountController.cardNumberController,
              TextInputType.number),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Card Type", addAccountController.cardTypeController,
              TextInputType.name),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Card Expiry", addAccountController.cardExpiryController,
              TextInputType.datetime),
          SizedBox(
            height: 2.h,
          ),
          _textFields("CVC", addAccountController.cardCVCController,
              TextInputType.number),
          SizedBox(
            height: 2.h,
          ),
          Obx(() {
            return _continue();
          }),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  Widget _continue() {
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
          if (addAccountController.nameOnCardController.text.isEmpty ||
              addAccountController.billingAddressController.text.isEmpty ||
              addAccountController.telephoneNumberController.text.isEmpty ||
              addAccountController.telephoneNumberController.text.isEmpty ||
              addAccountController.countryController.text.isEmpty ||
              addAccountController.cardNumberController.text.isEmpty ||
              addAccountController.cardTypeController.text.isEmpty ||
              addAccountController.cardExpiryController.text.isEmpty ||
              addAccountController.cardCVCController.text.isEmpty) {
            Fluttertoast.showToast(
              msg: "One of the input fields are empty",
              backgroundColor: Colors.red,
            );
          } else {
            addAccountController.addCardDetails();
          }
          /*addAccountController.cardScreenIndex.value = 1;*/
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: addAccountController.isCardAdded.value == true
              ? const Text("Continue")
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  Container _textFields(
      String hint,
      TextEditingController textEditingController,
      TextInputType textInputType) {
    return Container(
      width: double.infinity,
      child: TextField(
        keyboardType: textInputType,
        controller: textEditingController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.h,
            ),
            gapPadding: 1.0,
          ),
          hintText: hint,
          focusColor: Colors.blue,
          contentPadding: EdgeInsets.symmetric(
            vertical: 1.h,
            horizontal: 2.h,
          ),
        ),
      ),
    );
  }
}
