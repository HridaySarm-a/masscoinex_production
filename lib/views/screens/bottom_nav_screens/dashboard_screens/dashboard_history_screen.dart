import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/dashboard/screens/history_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/fiat_history_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardHistoryScreen extends StatelessWidget {
  final fiatHistory = [
    FiatHistoryModel(
      id: 1,
      title: "Paid by Credit Card",
      transactionID: "#ASDKL23423lkj",
      date: "20-09-2021",
      money: "INR 10000",
      status: "Success",
      statusColor: Colors.green,
    ),
    FiatHistoryModel(
      id: 2,
      title: "Withdraw",
      transactionID: "#FKL23423l43",
      date: "02-09-2021",
      money: "INR 4000",
      status: "Pending",
      statusColor: Colors.yellow.shade800,
    ),
    FiatHistoryModel(
      id: 3,
      title: "Deposit by UPI",
      transactionID: "#9423422FAS",
      date: "20-09-2021",
      money: "INR 5000",
      status: "Failed",
      statusColor: Colors.red,
    ),
  ];

  final _fiatController = Get.put(HistoryController());

  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVals.appbarColor,
        title: Text(
          "History",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          _fiatController.fiatHistory("");
        },
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sortFilter(),
                SizedBox(
                  height: 1.h,
                ),
                Obx(
                  () {
                    return _fiatController.isHistoryRefreshed.value == true
                        ? _fiatController.historyList.value.length != 0
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
          ),
        ),
      ),
    );
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
                  /*Icon(
                    Icons.sort_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    "Sort",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),*/
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
                        _fiatController.fiatHistory("");
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: Text("Deposit"),
                      onTap: () {
                        _fiatController.fiatHistory("deposit");
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: Text("Withdraw"),
                      onTap: () {
                        _fiatController.fiatHistory("withdraw");
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

  Widget _fiatHistory() {
    return Container(
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
                              "${_fiatController.historyList.value[index].mode}\n",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Transaction: ${_fiatController.historyList.value[index].transactionNo ?? ""}\n",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          ),
                        ),
                        TextSpan(
                          text:
                              "Transaction Fee: ${_fiatController.historyList.value[index].transactionFee ?? ""}\n",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          ),
                        ),
                        TextSpan(
                          text:
                              "${_fiatController.historyList.value[index].createdAt.day}-${_fiatController.historyList.value[index].createdAt.month}-${_fiatController.historyList.value[index].createdAt.year}",
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
                        "Amount: ${_fiatController.historyList.value[index].currency ?? ""} ${_fiatController.historyList.value[index].amount ?? ""}",
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
                        "Pay amount: ${_fiatController.historyList.value[index].currency ?? ""} ${_fiatController.historyList.value[index].amount ?? ""}",
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
                            color: statusColor(_fiatController
                                    .historyList.value[index].paymentStatus ??
                                ""),
                            size: 2.h,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            _fiatController
                                    .historyList.value[index].paymentStatus ??
                                "",
                            style: TextStyle(
                              color: statusColor(_fiatController.historyList
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
          itemCount: _fiatController.historyList.value.length),
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

  ListView _fiatHistoryy() {
    return ListView.separated(
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
                        text: "${fiatHistory[index].title}\n",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Transaction ${fiatHistory[index].transactionID}\n",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                        ),
                      ),
                      TextSpan(
                        text: fiatHistory[index].date,
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
                      fiatHistory[index].money,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
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
                          color: fiatHistory[index].statusColor,
                          size: 2.h,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          fiatHistory[index].status,
                          style: TextStyle(
                            color: fiatHistory[index].statusColor,
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
        itemCount: fiatHistory.length);
  }

  Container _sortFilters() {
    return Container(
      color: GlobalVals.backgroundColor,
      width: double.infinity,
      height: 6.h,
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
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
          TextButton(
            onPressed: () {},
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
}
