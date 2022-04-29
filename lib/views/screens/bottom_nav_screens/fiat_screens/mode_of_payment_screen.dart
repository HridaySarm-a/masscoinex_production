import 'package:flutter/material.dart';
import 'package:masscoinex/controllers/fiat/mode_of_payment_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/card/payment_method_card_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/upi/payment_mode_upi_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class ModeOfPaymentScreen extends StatelessWidget {
  final _controller = Get.put(ModeOfPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mode of Payment"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 3.h),
        child: Column(
          children: [
            //_oldList(),
            Obx(
              () => _controller.isPaymentLoading.value == false
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controller.paymentModeList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration( //                    <-- BoxDecoration
                              border: Border(bottom: BorderSide()),
                            ),
                            child: ListTile(

                              title: Text(
                                _controller.paymentModeList[index].payModeValue,
                              ),
                              subtitle: Text(
                                _controller.paymentModeList[index].description,
                              ),
                              onTap: () {
                                switch (_controller
                                    .paymentModeList[index].payModeName) {
                                  case "card":
                                    Get.to(
                                      PaymentModeCardScreen(
                                        paymentMethod: "card",
                                      ),
                                    );
                                    break;
                                  case "bank_transfer":
                                    Get.toNamed(Routes.getBanks);
                                    // Get.toNamed(Routes.bankPayment);
                                    break;
                                  case "upi":
                                    //Get.toNamed(Routes.upiPayment);
                                    Get.to(
                                      PaymentModeUpiScreen(
                                        paymentMethod: "upi",
                                      ),
                                    );
                                    break;
                                }
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Column _oldList() {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.credit_card_outlined,
            color: Colors.grey,
            size: 5.h,
          ),
          onTap: () {
            Get.toNamed(Routes.cardPayment);
          },
          title: Text(
            "Credit/Debit Card",
          ),
          subtitle: Text(
            "Pay using your Debit or Credit Card",
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.account_balance_outlined,
            color: Colors.grey,
            size: 5.h,
          ),
          onTap: () {
            Get.toNamed(Routes.bankPayment);
          },
          title: Text(
            "Bank Transfer",
          ),
          subtitle: Text(
            "Pay through Net Banking",
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.credit_score_outlined,
            color: Colors.grey,
            size: 5.h,
          ),
          onTap: () {
            Get.toNamed(Routes.upiPayment);
          },
          title: Text(
            "UPI Payment",
          ),
          subtitle: Text(
            "Pay using your UPI ID",
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.grey,
            size: 5.h,
          ),
          onTap: () {},
          title: Text(
            "Wallet",
          ),
          subtitle: Text(
            "Pay using Paytm/PhonePe/Amazon Pay & more",
          ),
        ),
      ],
    );
  }
}
