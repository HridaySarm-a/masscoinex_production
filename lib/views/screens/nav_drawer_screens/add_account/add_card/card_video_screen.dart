import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';

class NavCardVideoScreen extends StatelessWidget {
  final AddAccountController addAccountController;
  const NavCardVideoScreen({Key? key, required this.addAccountController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/video_card.svg",
            height: 20.h,
            width: 25.w,
          ),
          _cardUpload(
              "Please record a video by holding the card close to your face and make sure that it doesn't guard the face. Then read the note appears below. Ensure that the video is in high definition and both of your details and card are visible through the video\n\n\n",
              "'I Swadesh Singh, confirm that the VISA Card ending with 441 belongs to me and I am authorized to use this card for making online payments. Therefore, I give my full consent to NIKHAT INDUSTRIES INC to debit my card for all my future transactions on their platform without any objections from me. Furthermore, I am completely aware that I am completely aware that any charges to my card on their platform are non refundable and I shall not claim, protest or dispute any charges that is made by me or NIKHAT INDUSTRIES INC on their platform whatsoever. Thank you!'",
              null),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h, left: 1.h, right: 1.h),
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
                onPressed: () {
                  Get.offNamed(Routes.addCardOrBankComplete);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: const Text("Continue"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardUpload(String firstText, String secondText, String? thirdText) {
    return Card(
      elevation: 0.2.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.h),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 4.h, right: 4.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: firstText,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15.5.sp,
                        ),
                      ),
                      WidgetSpan(
                        child: Container(
                          child: Text(
                            secondText,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: GlobalVals.buttonColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      thirdText == null
                          ? WidgetSpan(child: SizedBox())
                          : TextSpan(
                              text: thirdText,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.sp,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Stack(
            children: [
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.h),
                    child: Image.asset(
                      "assets/avtr.png",
                      height: 15.h,
                      width: 25.w,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.colorBurn,
                      color: Color(0x33000000),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Icon(
                  Icons.video_call,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }
}
