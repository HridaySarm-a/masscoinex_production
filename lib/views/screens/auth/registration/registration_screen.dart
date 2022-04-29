import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/registration_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  final _logger = Logger();
  final _firstNameEditingController = TextEditingController();
  final _lastNameEditingController = TextEditingController();
  final _emailAddressEditingController = TextEditingController();
  final _enterPasswordEditingController = TextEditingController();
  final _confirmPasswordEditingController = TextEditingController();
  final _set4DigitPinEditingController = TextEditingController();
  final _confirm4DigitPinEditingController = TextEditingController();
  final _mobileNumberEditingController = TextEditingController();
  final _obscurePassword = false.obs;
  final _countryCode = "IN".obs;
  final RegistrationController _registrationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: GlobalVals.appbarColor,
        bottom: PreferredSize(
          child: Container(
            color: Colors.white,
            height: 0.1.h,
          ),
          preferredSize: Size.fromHeight(
            0.1.h,
          ),
        ),
      ),
      backgroundColor: GlobalVals.backgroundColor,
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Image.asset(
                  "assets/logo_white.png",
                  height: 12.h,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 3.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      3.h,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.1.h,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      _mobileNumber(),
                      SizedBox(
                        height: 2.h,
                      ),
                      _names(),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailAddressEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              5.h,
                            ),
                            gapPadding: 1.0,
                          ),
                          hintText: "Email Address",
                          focusColor: Colors.blue,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 1.h,
                            horizontal: 2.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Obx(() {
                        return _password();
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      _pins(),
                      SizedBox(
                        height: 2.h,
                      ),
                      _privacyPolicy(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.h),
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
                                if (_mobileNumberEditingController.text.isEmpty ||
                                    _firstNameEditingController.text.isEmpty ||
                                    _lastNameEditingController.text.isEmpty ||
                                    _emailAddressEditingController
                                        .text.isEmpty ||
                                    _enterPasswordEditingController
                                        .text.isEmpty ||
                                    _confirmPasswordEditingController
                                        .text.isEmpty ||
                                    _set4DigitPinEditingController
                                        .text.isEmpty ||
                                    _confirm4DigitPinEditingController
                                        .text.isEmpty) {
                                  GlobalVals.errorToast("Fill up input fields");
                                } else if (_enterPasswordEditingController
                                        .text !=
                                    _confirmPasswordEditingController.text) {
                                  GlobalVals.errorToast("Password mismatch");
                                } else if (_set4DigitPinEditingController
                                        .text !=
                                    _confirm4DigitPinEditingController.text) {
                                  GlobalVals.errorToast("Pin mismatch");
                                } else if (_registrationController
                                        .isCheckedCondition.value ==
                                    false) {
                                  GlobalVals.errorToast(
                                      "Check terms and condition");
                                } else if (_enterPasswordEditingController
                                        .text.length <
                                    8) {
                                  GlobalVals.errorToast(
                                      "Password can't be lower than 8 character");
                                } else if (_set4DigitPinEditingController
                                        .text.length <
                                    6) {
                                  GlobalVals.errorToast(
                                      "Pin can't be lower than 6 number");
                                } else {
                                  if (!validateStructure(
                                      _enterPasswordEditingController.text)) {
                                    GlobalVals.errorToast(
                                        "Password must contain\nMinimum 1 Upper case\n Minimum 1 lowercase \n Minimum 1 Numeric Number\n Minimum 1 Special Character\nCommon Allow Character ( ! @ # \$ & * ~ )");
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(_emailAddressEditingController
                                          .text)) {
                                    GlobalVals.errorToast("Not a valid mail");
                                  } else {
                                    _registrationController.registerUser(
                                        "${_firstNameEditingController.text} ${_lastNameEditingController.text} ",
                                        _emailAddressEditingController.text,
                                        _enterPasswordEditingController.text,
                                        _set4DigitPinEditingController.text,
                                        _mobileNumberEditingController.text,
                                        _countryCode.value);
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: _registrationController
                                            .isRegistering.value ==
                                        true
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text("Continue"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _privacyPolicy() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Checkbox(
            value: _registrationController.isCheckedCondition.value,
            onChanged: (value) {
              _registrationController.isCheckedCondition.value = value!;
            },
          ),
        ),
        Expanded(
          flex: 7,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "I have understood the ",
                ),
                TextSpan(
                  text: "Terms of Use",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Terms");
                    },
                ),
                TextSpan(
                  text: " and ",
                ),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Policy");
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _pins() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            controller: _set4DigitPinEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Set 6 digit PIN",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.h,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
          flex: 1,
          child: TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            controller: _confirm4DigitPinEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Confirm 6 digit PIN",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _password() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            obscureText: _obscurePassword.value,
            controller: _enterPasswordEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _obscurePassword.value = !_obscurePassword.value;
                },
                icon: Icon(
                  _obscurePassword.value == true
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Enter Password",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.h,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
          flex: 1,
          child: TextField(
            obscureText: _obscurePassword.value,
            controller: _confirmPasswordEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _obscurePassword.value = !_obscurePassword.value;
                },
                icon: Icon(
                  _obscurePassword.value == true
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Confirm Password",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _names() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: _firstNameEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "First Name",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.h,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
          flex: 1,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: _lastNameEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  5.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Last Name",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _mobileNumber() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(
          5.h,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 2.h),
        child: InternationalPhoneNumberInput(
          textFieldController: _mobileNumberEditingController,
          initialValue: PhoneNumber(isoCode: 'IN'),
          onInputChanged: (PhoneNumber number) {
            //
            print(number.phoneNumber);
            _countryCode.value = number.isoCode!;
            _logger.d(number.isoCode);
            _logger.d(number.dialCode);
            _logger.d(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
            setSelectorButtonAsPrefixIcon: true,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: Colors.black),
          formatInput: false,
          keyboardType: TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          hintText: "Mobile Number",
          inputBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
      ),
    );
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
