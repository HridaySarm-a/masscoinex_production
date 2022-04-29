import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class KycOrNotScreen extends StatelessWidget {
  final isKycSelected = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVals.backgroundColor,
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Image.asset(
                  "assets/logo_white.png",
                  height: 12.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Select your account type",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          2.h,
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.only(
                              bottom: isKycSelected.value == true ? 5.h : 0.0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87,
                                      blurRadius: isKycSelected.value == true
                                          ? 15.0
                                          : 0.0,
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 0.3.h,
                                    color: Colors.green,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/kyc.svg",
                                  height: 7.h,
                                  width: 2.w,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "KYC",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          isKycSelected.value = true;
                        },
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          2.h,
                        ),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.only(
                              bottom: isKycSelected.value == true ? 0.0 : 5.h),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87,
                                      blurRadius: isKycSelected.value == true
                                          ? 0.0
                                          : 15.0,
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 0.3.h,
                                    color: Colors.white,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/non_kyc.svg",
                                  height: 7.h,
                                  width: 2.w,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "NON-KYC",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          isKycSelected.value = false;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(5.h),
        child: Container(
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
            onPressed: () async {
              /*final _box = GetStorage();
              _box.write("isKyc", isKycSelected.value);*/
              var _hiveBox = await Hive.openBox(GlobalVals.hiveBox);
              _hiveBox.put("isKyc", isKycSelected.value);
              Get.toNamed(Routes.registration);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: const Text("Continue"),
            ),
          ),
        ),
      ),
    );
  }
}
