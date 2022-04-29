import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:masscoinex/controllers/login_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:masscoinex/views/components/auth/login_no_account.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.h,
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  const LoginNoAccount(),
                  const Text(
                    "Masscoinex will send a verification code by SMS to your mobile number. Carrier charges may apply.",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text(
                    "Please select your country and enter your mobile number",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        5.h,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(
                            5.h,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.5.h,
                          ),
                          child: Center(
                            child: Text(_loginController.countryName.value),
                          ),
                        ),
                      ),
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode:
                              true, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            _loginController.countryName.value =
                                country.displayNameNoCountryCode;
                            _loginController.countryCode.value =
                                "+" + country.phoneCode;
                            print(
                                'Select country: ${country.displayNameNoCountryCode} ${country.phoneCode}');
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              5.h,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.5.h,
                              horizontal: 1.5.h,
                            ),
                            child: Center(
                              child: Text(_loginController.countryCode.value),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        flex: 3,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  5.h,
                                ),
                                gapPadding: 1.0,
                              ),
                              hintText: "Mobile Number",
                              focusColor: Colors.blue,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 1.h,
                                horizontal: 2.h,
                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: _loginController.isCheckedCondition.value,
                          onChanged: (value) {
                            _loginController.isCheckedCondition.value = value!;
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
                  ),
                  SizedBox(
                    height: 2.h,
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
                        Get.toNamed(Routes.mobileVerification);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Text("Proceed Securely"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  RichText(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
