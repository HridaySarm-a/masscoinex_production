import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/dashboard/currency_select/transaction_history_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/transaction_history_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TransactionHistory extends StatelessWidget {
  final _currencyStats = Get.arguments;
  final _logger = Logger();
  final _transactionHistoryController = Get.put(TransactionHistoryController());

  @override
  Widget build(BuildContext context) {
    _transactionHistoryController.index.value = _currencyStats[0];
    _logger.d(_transactionHistoryController.index.value);
    _transactionHistoryController
        .getHistory(_transactionHistoryController.index.value);
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Flexible(
            child: _sortFilter(_transactionHistoryController.index.value),
          ),
          Expanded(
            flex: 15,
            child: Obx(
              () => _transactionHistoryController.isHistoryUpdated.value == true
                  ? _transactionHistoryController.historyList.isEmpty
                      ? Center(
                          child: Text("No transacion history available"),
                        )
                      : ListView.builder(
                          /* shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(), */
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.h),
                              padding: EdgeInsets.only(
                                top: 2.5.h,
                                bottom: 2.5.h,
                              ),
                              child: Card(
                                elevation: 0.5.h,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    1.5.h,
                                  ),
                                ),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            _transactionHistoryController
                                                .coinSymbol.value,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          CachedNetworkImage(
                                            imageUrl:
                                                _transactionHistoryController
                                                    .coinImage.value,
                                            height: 6.h,
                                            width: 6.h,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "TrxId: ${_transactionHistoryController
                                                  .historyList
                                                  .value[index]
                                                  .transactionNo}",
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
                                              _transactionHistoryController
                                                          .historyList
                                                          .value[index]
                                                          .cryptoAmount !=
                                                      null
                                                  ? "Amount: ${_transactionHistoryController.historyList.value[index].cryptoAmount}"
                                                  : "No Amount Available",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              _transactionHistoryController
                                                          .historyList
                                                          .value[index]
                                                          .cryptoValue !=
                                                      null
                                                  ? "Value: ${_transactionHistoryController.historyList.value[index].cryptoValue}"
                                                  : "No Value Available",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              _transactionHistoryController
                                                          .historyList
                                                          .value[index]
                                                          .transactionFee !=
                                                      null
                                                  ? "Transaction Fee: ${_transactionHistoryController.historyList.value[index].transactionFee}"
                                                  : "No transaction fee available",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              _transactionHistoryController
                                                          .historyList
                                                          .value[index]
                                                          .transactionFeeRate !=
                                                      null
                                                  ? "Transaction Fee Rate: ${_transactionHistoryController.historyList.value[index].transactionFeeRate}"
                                                  : "No transaction fee rate available",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              _transactionHistoryController
                                                          .historyList
                                                          .value[index]
                                                          .updatedAt !=
                                                      null
                                                  ? _transactionHistoryController
                                                      .historyList
                                                      .value[index]
                                                      .updatedAt
                                                      .toString()
                                                  : "No date available",
                                              style: TextStyle(
                                                color: GlobalVals.appbarColor,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            /* SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  _transactionHistoryList[index].currencyStat,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.sp,
                                  ),
                                ), */
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 10.h,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 0.5.h,
                                                horizontal: 1.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  1.h,
                                                ),
                                              ),
                                              child: Text(
                                                _transactionHistoryController
                                                            .historyList
                                                            .value[index]
                                                            .currency !=
                                                        null
                                                    ? _transactionHistoryController
                                                        .historyList
                                                        .value[index]
                                                        .currency
                                                    : "No currency available",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 1.h,
                                                  width: 1.h,
                                                  decoration: BoxDecoration(
                                                    color: _transactionHistoryController
                                                                .historyList
                                                                .value[index]
                                                                .transactionStatus ==
                                                            "Success"
                                                        ? Colors.green
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.h),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Text(
                                                  _transactionHistoryController
                                                      .historyList
                                                      .value[index]
                                                      .transactionStatus,
                                                  style: TextStyle(
                                                    color: _transactionHistoryController
                                                                .historyList
                                                                .value[index]
                                                                .transactionStatus ==
                                                            "Success"
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: _transactionHistoryController
                              .historyList.value.length,
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Container _sortFilter(var index) {
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
                 /* Icon(
                    Icons.sort_rounded,
                    color: Colors.white,
                  ),*/
                  Text(
                    "",
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
              Get.defaultDialog(
                title: "Select Filter",
                content: Column(
                  children: [
                    ListTile(
                      title: Text("Buy"),
                      onTap: () {
                        Get.back();
                        _transactionHistoryController.filter.value = "Buy";
                        _transactionHistoryController.getHistory(index);
                      },
                    ),
                    ListTile(
                      title: Text("Sell"),
                      onTap: () {
                        Get.back();
                        _transactionHistoryController.filter.value = "Sell";
                        _transactionHistoryController.getHistory(index);
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
}
