import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/bank_code/bank_code_response.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class AddBankScreenNewLogicAnother extends StatefulWidget {
  AddBankScreenNewLogicAnother({Key? key}) : super(key: key);

  @override
  State<AddBankScreenNewLogicAnother> createState() =>
      _AddBankScreenNewLogicAnotherState();
}

class _AddBankScreenNewLogicAnotherState
    extends State<AddBankScreenNewLogicAnother> {
  final _logger = Logger();

  final _fullNameController = TextEditingController();

  final _bankNameController = TextEditingController();

  final _accountNumberController = TextEditingController();

  final _branchStateController = TextEditingController();

  final _branchAddressController = TextEditingController();

  final _branchCityController = TextEditingController();

  final _branchZipController = TextEditingController();

  final _branchTelephoneController = TextEditingController();

  final _isUpdated = true.obs;

  late BankCodeResponse bankCodeResponse;

  Map<String, TextEditingController> dynamicTextEditingControllers = {};

  final _box = Hive.box(GlobalVals.hiveBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bank Account"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: _bankFields(),
        ),
      ),
    );
  }

  Widget _bankFields() {
    return Column(
      children: [
        _textFields("Your full name as per bank record", _fullNameController,
            TextInputType.name),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Full Bank  name", _bankNameController, TextInputType.name),
        SizedBox(
          height: 2.h,
        ),
        _textFields(
            "Account Number", _accountNumberController, TextInputType.number),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Branch State", _branchStateController, TextInputType.name),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          height: 17.h,
          child: TextField(
            controller: _branchAddressController,
            keyboardType: TextInputType.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  3.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Branch Address",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 5.h,
              ),
            ),
          ),
        ),
        _textFields("Branch City", _branchCityController, TextInputType.name),
        SizedBox(
          height: 2.h,
        ),
        _textFields(
            "Branch Zip Code", _branchZipController, TextInputType.number),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Branch Telephone", _branchTelephoneController,
            TextInputType.number),
        SizedBox(
          height: 2.h,
        ),
        FutureBuilder(
          builder: (context, AsyncSnapshot<BankCodeResponse> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var textController = TextEditingController();
                  dynamicTextEditingControllers.putIfAbsent(
                      snapshot.data!.result![index].bankCodename.toString(),
                      () => textController);
                  return Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      _textFields(
                          snapshot.data?.result![index].bankCodename
                              .toString(),
                          dynamicTextEditingControllers[snapshot
                              .data?.result![index].bankCodename
                              .toString()],
                          TextInputType.name)
                    ],
                  );
                },
                itemCount: bankCodeResponse.result?.length,
              );
            }
          },
          future: getBankCodes(),
        ),
        Container(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
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
              onPressed: () {
                if (_fullNameController.text.isEmpty ||
                    _bankNameController.text.isEmpty ||
                    _accountNumberController.text.isEmpty ||
                    _branchStateController.text.isEmpty ||
                    _branchAddressController.text.isEmpty ||
                    _branchCityController.text.isEmpty ||
                    _branchZipController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "One of the fields are empty",
                      backgroundColor: Colors.red);
                } else {
                  _addBank();
                }
                _logger.d("Add Bank accounts");
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: _isUpdated.value == true
                    ? const Text("Continue")
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }

  Container _textFields(
      String? hint,
      TextEditingController? textEditingController,
      TextInputType textInputType) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: textEditingController,
        keyboardType: textInputType,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.h,
            ),
            gapPadding: 1.0,
          ),
          hintText: hint,
          focusColor: Colors.blue,
          contentPadding: EdgeInsets.symmetric(
            vertical: 1.h,
            horizontal: 2.h,
          ),
        ),
      ),
    );
  }

  _addBank() async {
    _isUpdated.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    late String bankCode = "{";
    for (int i = 0; i < bankCodeResponse.result!.length; i++) {
      bankCode += bankCodeResponse.result![i].bankCodename.toString() +
          ":" +
          dynamicTextEditingControllers[
                  bankCodeResponse.result![i].bankCodename.toString()]!
              .text
              .toString();
    }
    bankCode += '}';

    final Map<String, dynamic> _body = {
      "bank_name": _bankNameController.text,
      "bank_address": _branchAddressController.text,
      "bank_telephone": _branchTelephoneController.text,
      "bank_state": _branchStateController.text,
      "bank_city": _branchCityController.text,
      "bank_zip": _branchZipController.text,
      "full_name": _fullNameController.text,
      "account_no": _accountNumberController.text,
      "dynamic_fields": bankCode
    };
    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.addBank),
        body: _body,
        headers: _header);
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      _clearTextFields(_bankNameController);
      _clearTextFields(_branchAddressController);
      _clearTextFields(_branchTelephoneController);
      _clearTextFields(_branchStateController);
      _clearTextFields(_branchCityController);
      _clearTextFields(_branchZipController);
      _clearTextFields(_fullNameController);
      _clearTextFields(_accountNumberController);
      _isUpdated.value = true;
      Fluttertoast.showToast(
          msg: "Bank Info Added", backgroundColor: Colors.green);
      Get.toNamed(Routes.currencySelectNewLogic);
    } else {
      _isUpdated.value = true;
      Fluttertoast.showToast(
          msg: "Add Error: ${_response.statusCode}",
          backgroundColor: Colors.red);
    }
  }

  _clearTextFields(TextEditingController textEditingController) {
    textEditingController.text = "";
  }

  Future<BankCodeResponse> getBankCodes() async {
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final response = await http.post(
        Uri.parse('https://test.masscoinex.com/api/bank-code'),
        headers: _header);
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      bankCodeResponse = BankCodeResponse.fromJson(data);
      print(bankCodeResponse.toString());
      return bankCodeResponse;
    } else {
      print(response.statusCode);
      print('Error getting bank code');
      return bankCodeResponse;
    }
  }
}
