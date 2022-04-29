import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/new_bank_screen_models/GetBanksResponse.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/models/fiat/payments/bank/bank_payment_method_model.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/new_select_bank_and_branch/select_branch_screen.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toast/toast.dart';

class SelectBankScreen extends StatefulWidget {
  const SelectBankScreen({Key? key}) : super(key: key);

  @override
  _SelectBankScreenState createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectBankScreen> {
  final _box = Hive.box(GlobalVals.hiveBox);
  GetBanksResponse getBanksResponse = GetBanksResponse();
  final _isListLoaded = true.obs;
  final _paymentMethodList = <PaymentMethod>[].obs;
  final _logger = Logger();
  var selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Select Bank"), backgroundColor: GlobalVals.appbarColor),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Expanded(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<GetBanksResponse> snapshot) {
                  if (!snapshot.hasData) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration( //                    <-- BoxDecoration
                              border: Border(bottom: BorderSide()),
                            ),
                            child: ListTile(
                              // shape: RoundedRectangleBorder(
                              //     side: BorderSide(color: Colors.black, width: 1),
                              //     borderRadius: BorderRadius.circular(5)),

                              onTap: () {
                                _box.put(GlobalVals.paymentMethodId,
                                    _paymentMethodList.value[index].id.toString());
                                _box.put(
                                    GlobalVals.paymentMethodName,
                                    _paymentMethodList.value[index].bankName
                                        .toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectBranchScreen(
                                        id: snapshot
                                            .data?.paymentMethods![index].id),
                                  ),
                                );
                              },
                              // tileColor: selectedId ==
                              //         snapshot.data?.paymentMethods![index].id
                              //     ? Colors.grey
                              //     : null,
                              title: Text(
                                snapshot.data!.paymentMethods![index].bankName
                                    .toString(),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: getBanksResponse.paymentMethods!.length,
                    );
                  }
                },
                future: getBanks(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<GetBanksResponse> getBanks() async {
    final _userInfo = UserModel.fromJson(jsonDecode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    Map<String, String> _body = {
      'Accept': 'application/json',
      'payment_mode': 'bank_transfer'
    };

    final response = await http.post(
        Uri.parse('https://test.masscoinex.com/api/payment-method'),
        headers: _header,
        body: _body);
    var data = jsonDecode(response.body.toString());
    var _result = bankPaymentMethodModelFromJson(response.body);

    _logger.d(response.body);
    if (response.statusCode == 200) {
      _paymentMethodList.value = _result.paymentMethods;
      getBanksResponse = GetBanksResponse.fromJson(data);
      return getBanksResponse;
    } else {
      return getBanksResponse;
    }
  }
}

// class BankItemBuilder extends StatelessWidget {
//   PaymentMethods? paymentMethod;
//
//   BankItemBuilder(PaymentMethods paymentMethod) {
//     this.paymentMethod = paymentMethod;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//     // Container(
//     //   width: double.infinity,
//     //   height: 100,
//     //   child: GestureDetector(
//     //     child: Card(
//     //       child: Align(
//     //         child: Padding(
//     //           padding: const EdgeInsets.only(left: 16),
//     //           child: Text(
//     //             paymentMethod!.bankName.toString(),
//     //             style: TextStyle(
//     //               fontSize: 16,
//     //               fontWeight: FontWeight.bold,
//     //             ),
//     //           ),
//     //         ),
//     //         alignment: Alignment.centerLeft,
//     //       ),
//     //     ),
//     //     onTap: () {
//     //       Get.to(
//     //         SelectBranchScreen(
//     //           id: paymentMethod!.id,
//     //         ),
//     //       );
//     //     },
//     //   ),
//     // );
//   }
// }
