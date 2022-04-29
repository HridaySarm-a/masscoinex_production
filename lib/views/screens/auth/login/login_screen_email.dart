import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/login/login_controller_email.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:masscoinex/views/components/auth/login_no_account.dart';
import 'package:masscoinex/views/components/auth/obscuring_text_editing_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class LoginEmailScreen extends StatelessWidget {
  FocusNode _focus = FocusNode();
  final _emailTextController = TextEditingController();
  final _passwordTextControllerObscure = ObscuringTextEditingController();
  final _passwordTextController = TextEditingController();
  final _isPasswordVisible = true.obs;
  final _logger = Logger();
  final LoginControllerEmail _loginControllereEmail =
      Get.put(LoginControllerEmail());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Email Credentials"),
        backgroundColor: GlobalVals.appbarColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.h,
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                const LoginNoAccount(),
                _topText(),
                SizedBox(
                  height: 2.h,
                ),
                _textInputFields(),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.resetPassword);
                        },
                        child: Text("Reset Password"),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.resetPin);
                        },
                        child: Text("Reset Pin"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                _checkBoxTermsAndCondition(),
                SizedBox(
                  height: 2.h,
                ),
                _buttonProceed(),
                SizedBox(
                  height: 3.h,
                ),
                _disclaimer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buttonProceed() {
    return Container(
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
            if (_loginControllereEmail.isCheckedCondition.value == false) {
              GlobalVals.errorToast(
                "Please enable terms and condition",
              );
            } else if (_emailTextController.text.isEmpty ||
                _loginControllereEmail.typedPassword.value.isEmpty) {
              GlobalVals.errorToast(
                "Input Fields are empty",
              );
            } else {
              _loginControllereEmail.checkUserCredentials(
                  _emailTextController.text,
                  _loginControllereEmail.typedPassword.value);
            }
            _logger.d(_loginControllereEmail.typedPassword.value);
            //Get.toNamed(Routes.emailVerification);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: _loginControllereEmail.isLoggingLoading.value == true
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Proceed Securely"),
          ),
        ),
      ),
    );
  }

  RichText _disclaimer() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Disclaimer\n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.sp,
            ),
          ),
          TextSpan(
            text:
                "Trading in cryptocurrencies is subject to market, technical and legal risk",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }

  Row _checkBoxTermsAndCondition() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Obx(
            () => Checkbox(
              value: _loginControllereEmail.isCheckedCondition.value,
              onChanged: (value) {
                _loginControllereEmail.isCheckedCondition.value = value!;
              },
            ),
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
                const TextSpan(
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

  Column _textInputFields() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: TextField(
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
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
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          height: 70.0,
          child: Obx(
            () => TextField(
              onTap: (){
                print('clicked passfield');
              },
              focusNode: _focus,
              enabled: true,
              controller: _isPasswordVisible.value == false
                  ? _passwordTextController
                  : _passwordTextControllerObscure,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _isPasswordVisible.value = !_isPasswordVisible.value;
                    if (_isPasswordVisible.value == true) {
                      _passwordTextController.text =
                          _loginControllereEmail.typedPassword.value;
                      _passwordTextController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _passwordTextController.text.length));
                    } else {
                      _passwordTextControllerObscure.text =
                          _loginControllereEmail.typedPassword.value;
                      _passwordTextControllerObscure.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset:
                                  _passwordTextControllerObscure.text.length));
                    }
                  },
                  icon: Icon(
                    _isPasswordVisible.value == true
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
                hintText: "Password",
                focusColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  horizontal: 2.h,
                ),
              ),
              onChanged: (value) {
                _loginControllereEmail.typedPassword.value = value;
                if (_isPasswordVisible.value == true) {
                  _passwordTextController.text = value;
                } else {
                  _passwordTextControllerObscure.text = value;
                }
                _logger.d(
                    "From Controller: ${_loginControllereEmail.typedPassword.value}");
                _logger.d("From Value: ${value}");
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _topText() {
    return Column(
      children: [
        /*Container(
          width: double.infinity,
          child: const Text(
            "Masscoinex will send a verification code to your email.",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),*/
        Container(
          width: double.infinity,
          child: const Text(
            "Please enter your email credentials",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
