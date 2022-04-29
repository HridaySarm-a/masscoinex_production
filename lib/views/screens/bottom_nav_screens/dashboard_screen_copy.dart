import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/dashboard/dashboard_controller_copy.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreenCopy extends StatelessWidget {
  final dashBoardControllerInit = Get.lazyPut(() => DashBoardControllerCopy());
  final _dashBoardController = Get.find<DashBoardControllerCopy>();
  final _logger = Logger();
  //final _box = Hive.box(GlobalVals.hiveBox);
  @override
  Widget build(BuildContext context) {
    /* final _profileInfo =
        ProfileModel.fromJson(json.decode(_box.get(GlobalVals.profileInfo))); */
    /* var _result = DashboardModel.fromJson(
        json.decode(_dashBoardController.responseResult.value)); */
    //handleAppLifecycleState();
    return RefreshIndicator(
      onRefresh: () async {
        _dashBoardController.getAllDashboard();
        _logger.d("Pulled");
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: GlobalVals.backgroundColor,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Balance",
                            style: TextStyle(
                                color: GlobalVals.backgroundColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Obx(
                        () => SizedBox(
                          child: _dashBoardController.responseResult.value == ""
                              ? const CircularProgressIndicator(
                                  color: Colors.deepPurple,
                                )
                              : _balanceText(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonDepoWithdraw(
                          Colors.green.shade600,
                          Icons.arrow_downward,
                          "Deposit",
                          () => Get.toNamed(Routes.dashboardDeposit)),
                      _buttonDepoWithdraw(
                          GlobalVals.appbarColor,
                          Icons.arrow_upward,
                          "Withdraw",
                          () => Get.toNamed(Routes.dashboardWithdraw)),
                      _buttonDepoWithdraw(Colors.red, Icons.history, "History",
                          () => Get.toNamed(Routes.dashboardHistory)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Divider(
                  height: 1.h,
                  color: Colors.grey,
                ),
              ],
            ),
            Obx(
              () => SizedBox(
                child: _dashBoardController.responseResult.value == ""
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          CircularProgressIndicator(),
                        ],
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          var _result = DashboardModel.fromJson(json.decode(
                              _dashBoardController.responseResult.value));
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(2.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Card(
                                            elevation: 0.4.h,
                                            shadowColor: Colors.grey.shade100,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5.h,
                                              ),
                                            ),
                                            child: Container(
                                              height: 6.h,
                                              width: 6.h,
                                              padding: EdgeInsets.all(1.5.h),
                                              child: CachedNetworkImage(
                                                imageUrl: _result
                                                    .cryptoData[index]
                                                    .coinImage,
                                                fit: BoxFit.fill,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Expanded(
                                            child: RichText(
                                              overflow: TextOverflow.fade,
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: _result
                                                            .cryptoData[index]
                                                            .coinName +
                                                        "\n",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  /*TextSpan(
                                                    text:
                                                        "(${_result.cryptoData[index].coinSymbol})" +
                                                            "\n",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),*/
                                                  TextSpan(
                                                    text: _result
                                                        .cryptoData[index]
                                                        .cryptoWallet
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: _result
                                                            .cryptoData[index]
                                                            .buyPrice +
                                                        "\n",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "Buy",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(
                                                        GlobalVals.raiseColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: _result
                                                            .cryptoData[index]
                                                            .sellPrice +
                                                        "\n",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "Sell",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(
                                                        GlobalVals.raiseColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(Routes.currencySelected,
                                    parameters: {'index': index.toString()});
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1.h,
                            color: Colors.grey,
                          );
                        },
                        itemCount: _dashBoardController.resultLength.value,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceText() {
    var _result = DashboardModel.fromJson(
        json.decode(_dashBoardController.responseResult.value));
    var _currency = _result.wallet.currency ?? "";
    return Text(
      "${_result.wallet.amount.toString()} $_currency",
      style: TextStyle(
        color: GlobalVals.backgroundColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  ElevatedButton _buttonDepoWithdraw(Color color, IconData iconData,
      String buttonText, VoidCallback voidCallback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2.h,
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
        padding: EdgeInsets.only(
            left: 1.5.h, right: 1.5.h, top: 0.5.h, bottom: 0.5.h),
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

  handleAppLifecycleState() {
    SystemChannels.lifecycle.setMessageHandler((msg) {
      print('SystemChannels> $msg');
      var _logger = Logger();
      _logger.d('SystemChannels> $msg');
      switch (msg) {
        case "AppLifecycleState.paused":
          break;
        case "AppLifecycleState.inactive":
          break;
        case "AppLifecycleState.resumed":
          Future.delayed(Duration(milliseconds: 500), () {
            _dashBoardController.getAllDashboard();
          });
          break;
        case "AppLifecycleState.suspending":
          break;
        default:
      }
      return Future.value("");
    });
  }
}
