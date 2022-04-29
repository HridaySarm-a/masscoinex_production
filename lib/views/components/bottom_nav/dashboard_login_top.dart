import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardLoginTop extends StatelessWidget {
  const DashboardLoginTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF422eb7),
            Color(0xFF7022a9),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.amber.shade600,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.h),
                  ),
                ),
              ),
              onPressed: () {
                Get.toNamed(Routes.loginEmail);
                //Get.toNamed(Routes.addAccount);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                child: Text("Login"),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Get started with Masscoinex\n",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  TextSpan(
                    text: "Login or Register here",
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
