import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/support_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Security Center",
        ),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: FutureBuilder<SupportModel?>(
        future: _getSupport(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                _tiles(
                  Icons.headset_mic_outlined,
                  snapShot.data!.result.telephone1,
                  () async {
                    await launch("tel:${snapShot.data!.result.telephone1}");
                  },
                ),
                _tiles(
                  Icons.headset_mic_outlined,
                  snapShot.data!.result.telephone2,
                  () async {
                    await launch("tel:${snapShot.data!.result.telephone2}");
                  },
                ),
                _tiles(
                  Icons.email_outlined,
                  snapShot.data!.result.email1,
                  () async {
                    await launch("mailto:${snapShot.data!.result.email1}");
                  },
                ),
                _tiles(
                  Icons.email_outlined,
                  snapShot.data!.result.email2,
                  () async {
                    await launch("mailto:${snapShot.data!.result.email2}");
                  },
                ),
                _tiles(
                  Icons.chat,
                  snapShot.data!.result.liveConnect1,
                  () async {
                    await launch(snapShot.data!.result.liveConnect1);
                  },
                ),
                _tiles(
                  Icons.chat,
                  snapShot.data!.result.liveConnect2,
                  () async {
                    await launch(snapShot.data!.result.liveConnect2);
                  },
                ),
              ],
            );
          } else if (snapShot.hasError) {
            return Center(
              child: Text("No Data Available"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListTile _tiles(IconData iconData, String title, VoidCallback voidCallback) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.grey,
        size: 3.h,
      ),
      title: Text(
        title,
      ),
      onTap: voidCallback,
    );
  }

  Future<SupportModel?> _getSupport() async {
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
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.support),
      headers: _header,
    );
    if (_response.statusCode == 200) {
      final _result = SupportModel.fromJson(json.decode(_response.body));
      return _result;
    } else {
      GlobalVals.errorToast("Server Error: ${_response.statusCode}");
      return null;
    }
  }
}
