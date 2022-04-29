import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/reset_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Security Center",
        ),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          _tiles(
            "Change Pin",
            "You can simply change pin from here",
            () {
              Get.toNamed(Routes.changePin);
            },
          ),
          _tiles(
            "Change Password",
            "You can simply change password from here",
            () {
              Get.toNamed(Routes.changePasswordScreen);
            },
          ),
          /*_tiles(
            "App Lock",
            "Lock your Masscoinex App. Use your pin to unlock",
            () {},
          ),*/
          _tiles(
            "Activity Log",
            "You can view login here",
            () {},
          ),
          _tiles(
            "Deactivate Account",
            "You can deactivate your account from here",
            () {
              _deactivate(context);
            },
          ),
        ],
      ),
    );
  }

  ListTile _tiles(String title, String subTitle, VoidCallback voidCallback) {
    return ListTile(
      dense: true,
      title: Text(
        title,
      ),
      subtitle: Text(
        subTitle,
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.grey,
        size: 5.h,
      ),
      onTap: voidCallback,
    );
  }

  _deactivate(BuildContext context) async {
    showLoaderDialog(context);
    final _logger = Logger();
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.deactivate),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      final _result = ResetModel.fromJson(json.decode(_response.body));
      final _box = await Hive.openBox(GlobalVals.hiveBox);
      _box.put(GlobalVals.user, "");
      _box.put(GlobalVals.isLoggedIn, false);
      GlobalVals.successToast(_result.result);
      Get.back();
      Get.offAllNamed(Routes.splashScreen);
    } else {
      GlobalVals.errorToast("Could not log out. Please try again later");
    }
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Deactivating your account..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
