import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/change_password_model.dart';
import 'package:masscoinex/models/get_card_model.dart';
import 'package:masscoinex/models/support_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Card List",
        ),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: FutureBuilder<GetCardModel?>(
        future: _getCards(),
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
                          "Name on Card", _result[index].nameOnCard.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames("Billing Address",
                          _result[index].billingAddress.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Telephone", _result[index].telephone.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames("Country", _result[index].country.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Card Number", _result[index].cardNumber.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Card Type", _result[index].cardType.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Card Expiry", _result[index].cardExpiry.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames("Card CVC", _result[index].cardCvc.toString()),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "State",
                          _result[index].state != null
                              ? _result[index].state.toString()
                              : ""),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "City",
                          _result[index].city != null
                              ? _result[index].city.toString()
                              : ""),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Zip",
                          _result[index].zip != null
                              ? _result[index].zip.toString()
                              : ""),
                      SizedBox(
                        height: 2.h,
                      ),
                      _bankNames(
                          "Card Status", _result[index].cardStatus.toString()),
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

  Future<GetCardModel?> _getCards() async {
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
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getCards),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      try {
        return GetCardModel.fromJson(json.decode(_response.body));
      } catch (e) {
        GlobalVals.errorToast("No Card Found");
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
