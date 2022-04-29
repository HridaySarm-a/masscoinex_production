import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lottie/lottie.dart';

class AddAccountCompleteScreen extends StatelessWidget {
  const AddAccountCompleteScreen({Key? key}) : super(key: key);

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
                onPressed: ()async {
                  Get.offAllNamed(Routes.mainScreenCopy);
                  var _box = await Hive.openBox(GlobalVals.hiveBox);
                  _box.put("loggedIn", true);
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
