import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lottie/lottie.dart';

class NavAddAccountCompleteScreen extends StatelessWidget {
  const NavAddAccountCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Account"),
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
      body: Center(
        child: Container(
          height: 43.h,
          margin: EdgeInsets.all(2.h),
          padding: EdgeInsets.all(3.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              2.h,
            ),
          ),
          child: Column(
            children: [
              Lottie.asset("assets/success.json"),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Account added successful",
                style: TextStyle(
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ElevatedButton(
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
                  /* Get.offAllNamed(Routes.mainScreenCopy);
                  GetStorage box = GetStorage();
                  box.write("loggedIn", true); */
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
