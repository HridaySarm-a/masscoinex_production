import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _box = Hive.box(GlobalVals.hiveBox);
    final _dashboardValue =
        DashboardModel.fromJson(json.decode(_box.get(GlobalVals.dashBoard)));
    final listOfNotification = _dashboardValue.notifications;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification Screen",
        ),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: ListView.builder(
        itemCount: listOfNotification.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Card(
              elevation: 1.h,
              child: Row(
                children: [
                  _colorOfNotification(
                      index % 2 == 0 ? Colors.blue : GlobalVals.appbarColor),
                  Expanded(
                    flex: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.notifications,
                          color: GlobalVals.buttonColor,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          listOfNotification[index].notificationMsg,
                        ),
                      ],
                    ),
                  ),
                  _colorOfNotification(
                      index % 2 == 0 ? Colors.blue : GlobalVals.appbarColor),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded _colorOfNotification(Color colors) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 10.h,
        color: colors,
      ),
    );
  }
}
