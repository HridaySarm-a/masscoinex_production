import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginNoAccount extends StatelessWidget {
  const LoginNoAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      child: Container(
        width: double.infinity,
        color: Color(0xFFeff6ff),
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "No account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: "Create one here!",
                        style: TextStyle(
                          color: GlobalVals.textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.kycOrNot);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
