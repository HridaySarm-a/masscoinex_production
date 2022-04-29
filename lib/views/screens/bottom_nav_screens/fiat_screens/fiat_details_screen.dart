import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/fiat/fiat_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/fiat_history_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FiatDetailsScreen extends StatelessWidget {
  final FiatController fiatController;
  final _logger = Logger();

  FiatDetailsScreen({Key? key, required this.fiatController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _depositWithdrawButtons(),
          SizedBox(
            height: 1.h,
          ),
          _sortFilter(),
          SizedBox(
            height: 1.h,
          ),
          Obx(
            () {
              return fiatController.isHistoryRefreshed.value == true
                  ? fiatController.historyList.value.length != 0
                      ? _fiatHistory()
                      : Center(
                          child: Text("No data available"),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _fiatHistory() {
    return SingleChildScrollView(
      child: Container(
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${fiatController.historyList.value[index].mode}\n",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Transaction: ${fiatController.historyList.value[index].transactionNo ?? ""}\n",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Transaction Fee: ${fiatController.historyList.value[index].transactionFee ?? ""}\n",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          TextSpan(
                            text:
                                "${fiatController.historyList.value[index].createdAt.day}-${fiatController.historyList.value[index].createdAt.month}-${fiatController.historyList.value[index].createdAt.year}",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Amount: ${fiatController.historyList.value[index].currency ?? ""} ${fiatController.historyList.value[index].amount ?? ""}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Pay amount: ${fiatController.historyList.value[index].currency ?? ""} ${fiatController.historyList.value[index].amount ?? ""}",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.circle,
                              color: statusColor(fiatController
                                      .historyList.value[index].paymentStatus ??
                                  ""),
                              size: 2.h,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              fiatController
                                      .historyList.value[index].paymentStatus ??
                                  "",
                              style: TextStyle(
                                color: statusColor(fiatController.historyList
                                        .value[index].paymentStatus ??
                                    ""),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 0.3.h,
                color: Colors.grey.shade300,
              );
            },
            itemCount: fiatController.historyList.value.length),
      ),
    );
  }

  Color statusColor(String status) {
    if (status == "Success") {
      return Colors.green;
    } else if (status == "Pending") {
      return Colors.yellow.shade800;
    } else {
      return Colors.red;
    }
  }

  Container _sortFilter() {
    return Container(
      color: GlobalVals.backgroundColor,
      width: double.infinity,
      height: 6.h,
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: false,
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.sort_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    "Sort",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _logger.d("filter clcked");
              Get.defaultDialog(
                title: "Select to filter",
                content: Column(
                  children: [
                    ListTile(
                      title: Text("All"),
                      onTap: () {
                        fiatController.fiatHistory("");
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: Text("Deposit"),
                      onTap: () {
                        fiatController.fiatHistory("deposit");
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: Text("Withdraw"),
                      onTap: () {
                        fiatController.fiatHistory("withdraw");
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ),
                Text(
                  "Filter",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _depositWithdrawButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buttonDepoWithdraw(
              Colors.green.shade600, Icons.arrow_downward, "Deposit", () {
            print(fiatController.fiatIndex.value);
            fiatController.fiatIndex.value = 1;
          }),
          _buttonDepoWithdraw(GlobalVals.appbarColor, Icons.arrow_upward,
              "Withdraw", () => fiatController.fiatIndex.value = 2),
        ],
      ),
    );
  }

  ElevatedButton _buttonDepoWithdraw(Color color, IconData iconData,
      String buttonText, VoidCallback voidCallback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 1.h,
        minimumSize: Size.zero,
        // <-- Add this
        padding: EdgeInsets.zero,
        primary: color,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(2.h),
        ),
      ),
      onPressed: voidCallback,
      child: Padding(
        padding:
            EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 1.h, bottom: 1.h),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 2.h,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(buttonText),
          ],
        ),
      ),
    );
  }
}
