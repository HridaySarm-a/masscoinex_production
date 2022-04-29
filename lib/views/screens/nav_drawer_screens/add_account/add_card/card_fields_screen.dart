import 'package:flutter/material.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NavCardFieldsScreen extends StatelessWidget {
  final AddAccountController addAccountController;
//No Need
  const NavCardFieldsScreen({Key? key, required this.addAccountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _textFields("Name on Card"),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: double.infinity,
            height: 17.h,
            child: TextField(
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
          SizedBox(
            height: 2.h,
          ),
          _textFields("Telephone Number"),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Country"),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Card Number"),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Card Type"),
          SizedBox(
            height: 2.h,
          ),
          _textFields("Card Expiry"),
          SizedBox(
            height: 2.h,
          ),
          _textFields("CVV"),
          SizedBox(
            height: 2.h,
          ),
          _continue(),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
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
          addAccountController.cardScreenIndex.value = 1;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: const Text("Continue"),
        ),
      ),
    );
  }

  Container _textFields(String hint) {
    return Container(
      width: double.infinity,
      child: TextField(
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
