import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/change_password_model.dart';
import 'package:masscoinex/models/get_bank_model.dart';
import 'package:masscoinex/models/get_card_model.dart';
import 'package:masscoinex/models/support_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class BankListScreen extends StatelessWidget {
  const BankListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank List",
        ),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: FutureBuilder<GetBankModel?>(
        future: _getBanks(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            var _result = snapShot.data!.result;
            return ListView.builder(
              itemCount: _result.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2.h),
                  margin: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h),
                    border: Border.all(
                      width: 0.1.h,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bankNames(
                          "Bank Name", _result[index].bankName.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames("Bank Address",
                          _result[index].bankAddress.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Bank State", _result[index].bankState.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Bank City", _result[index].bankCity.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames("Bank Zip", _result[index].bankZip.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Bank Code", _result[index].bankCode.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Bank Telephone",
                          _result[index].bankTelephone != null
                              ? _result[index].bankTelephone.toString()
                              : ""),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Full Name", _result[index].fullName.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames("Account Number",
                          _result[index].accountNo.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Bank Status", _result[index].bankStatus.toString()),
                    ],
                  ),
                );
              },
            );
          } else if (snapShot.hasError) {
            return Center(child: Text("Error fetching data"));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<GetBankModel?> _getBanks() async {
    final _logger = Logger();
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Accept': 'application/json',
      //'Authorization': 'Bearer ${GlobalVals.defaultToken}',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getBanks),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      try {
        return GetBankModel.fromJson(json.decode(_response.body));
      } catch (e) {
        GlobalVals.errorToast("No Bank Found");
        return null;
      }
    } else {
      return null;
    }
  }

  Widget _bankNames(String initText, String text) {
    return Text(
      "$initText: $text",
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }
}
