import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/dashboard/dashboard_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:masscoinex/views/components/bottom_nav/dashboard_login_top.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatelessWidget {
  final _dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DashboardLoginTop(),
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
                        var _result = DashboardModel.fromJson(json
                            .decode(_dashBoardController.responseResult.value));
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
                                            borderRadius: BorderRadius.circular(
                                              5.h,
                                            ),
                                          ),
                                          child: Container(
                                            height: 6.h,
                                            width: 6.h,
                                            padding: EdgeInsets.all(1.5.h),
                                            child: CachedNetworkImage(
                                              imageUrl: _result
                                                  .cryptoData[index].coinImage,
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
                                                    fontSize: 17.sp,
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Buy",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Sell",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                              /* Get.toNamed(Routes.currencySelected,
                                  parameters: {'index': "0"}); */
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
    );
  }
}
