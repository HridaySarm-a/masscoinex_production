import 'dart:convert';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/new_bank_screen_models/GetBranchResponse.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toast/toast.dart';

class SelectBranchScreen extends StatefulWidget {
  late int? id;

  SelectBranchScreen({required int? id}) {
    this.id = id;
  }

  @override
  _SelectBranchScreenState createState() => _SelectBranchScreenState();
}

class _SelectBranchScreenState extends State<SelectBranchScreen> {
  final _box = Hive.box(GlobalVals.hiveBox);
  GetBranchResponse getBranchResponse = GetBranchResponse();
  var selectedId;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Select Branch"),
          backgroundColor: GlobalVals.appbarColor),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 7,
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<GetBranchResponse> snapshot) {
                  if (!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              //                    <-- BoxDecoration
                              border: Border(bottom: BorderSide()),
                            ),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  isSelected = true;
                                  selectedId = snapshot
                                      .data!.modeDataFields![index].fieldValue;
                                });
                              },
                              tileColor: selectedId ==
                                      snapshot.data!.modeDataFields![index]
                                          .fieldValue
                                  ? Color(0xffD3D3D3)
                                  : null,
                              title: Text(
                                snapshot.data!.modeDataFields![index]
                                            .fieldName !=
                                        null
                                    ? snapshot
                                        .data!.modeDataFields![index].fieldName
                                        .toString()
                                    : "",
                              ),
                              subtitle: Text(
                                snapshot.data!.modeDataFields![index]
                                            .fieldValue !=
                                        null
                                    ? snapshot
                                        .data!.modeDataFields![index].fieldValue
                                        .toString()
                                    : "",
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: getBranchResponse.modeDataFields!.length,
                    );
                  }
                },
                future: getBranches(widget.id),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: _continue(() {
                  if(isSelected){
                    Get.toNamed(Routes.bankPayment);
                  }else{
                    Toast.show("Please select a branch", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  }

                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _continue(VoidCallback voidCallback) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            GlobalVals.buttonColor,
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                5.h,
              ),
            ),
          ),
        ),
        onPressed: voidCallback,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Text('Continue'),
        ),
      ),
    );
  }

  Future<GetBranchResponse> getBranches(int? id) async {
    final _userInfo = UserModel.fromJson(jsonDecode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    Map<String, String> _body = {
      'Accept': 'application/json',
      'payment_mode': 'bank_transfer',
      'payment_method_id': '$id'
    };

    final response = await http.post(
        Uri.parse('https://test.masscoinex.com/api/payment-method-details'),
        headers: _header,
        body: _body);

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      getBranchResponse = GetBranchResponse.fromJson(data);
      return getBranchResponse;
    } else {
      print(response.body.toString());
      return getBranchResponse;
    }
  }
}
//
// class BranchItem extends StatefulWidget {
//   late ModeDataFields modeDataField;
//
//   BranchItem(ModeDataFields modeDataField) {
//     this.modeDataField = modeDataField;
//   }
//
//   @override
//   State<BranchItem> createState() => _BranchItemState();
// }
//
// class _BranchItemState extends State<BranchItem> {
//   bool isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//   }
// }
