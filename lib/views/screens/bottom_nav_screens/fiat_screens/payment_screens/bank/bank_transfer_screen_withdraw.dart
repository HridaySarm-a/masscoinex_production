import 'package:flutter/material.dart';
import 'package:masscoinex/controllers/fiat/payment_method/bank_payment_controller.dart';
import 'package:masscoinex/controllers/fiat/payment_method/bank_payment_controller_withdraw.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/bank_transfer_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class BankTransferScreenWithdraw extends StatelessWidget {
  final _controller = Get.put(BankPaymentControllerWithdraw());

  BankTransferScreenWithdraw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Transfer"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Container(
        margin: EdgeInsets.all(2.h),
        child: Column(
          children: [
            Text(
              "Make sure you have the correct bank accounts linked",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() => _controller.isListLoaded.value == true
                ? _controller.isThereAnyBankSaved.value == true
                    ? _bankDropdown()
                    : SizedBox()
                : SizedBox()),
            SizedBox(
              height: 2.h,
            ),
            _showBankDetails(),
            SizedBox(
              height: 2.h,
            ),
            Obx(
              () => _controller.isListLoaded.value == true
                  ? const SizedBox()
                  : const CircularProgressIndicator(),
            ),
            Obx(
              () => _controller.isListLoaded.value == true
                  ? _upiView()
                  : const SizedBox(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return _continue(
            "Continue",
            _controller.isButtonActive.value == false
                ? null
                : () {
                    _controller.saveDeposit();
                  });
      }),
    );
  }

  Widget _upiView() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            _converter(),
          ],
        ),
      ),
    );
  }

  Row _converter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: _amountAndCurrency(
            CrossAxisAlignment.start,
            "Amount to Withdraw",
            TextAlign.start,
            _controller.amountController,
            null,
            "",
            false,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(top: 3.h),
            child: Icon(
              Icons.shuffle,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _amountAndCurrency2(
            CrossAxisAlignment.end,
            "Currency",
            TextAlign.end,
            _controller.currencyController,
            "",
            null,
            false,
          ),
        ),
      ],
    );
  }

  Column _cryptoValue(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextEditingController textEditingController,
      BorderRadius borderRadius,
      Color color,
      TextAlign textAlign,
      String? prefixText,
      String? suffixTest) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: TextField(
            enabled: false,
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
              prefix: prefixText != null ? Text(prefixText) : SizedBox(),
              suffix: suffixTest != null ? Text(suffixTest) : SizedBox(),
              hintText: "Enter Crypto Value",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _amountAndCurrency2(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextAlign textAlign,
      TextEditingController textEditingController,
      String? prefixText,
      String? suffixTest,
      bool isEnabled) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(1.h),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: TextField(
            enabled: isEnabled,
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
              prefix: prefixText != null ? Text(prefixText) : SizedBox(),
              suffix: suffixTest != null ? Text(suffixTest) : SizedBox(),
              hintText: "Enter Amount",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _amountAndCurrency(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextAlign textAlign,
      TextEditingController textEditingController,
      String? prefixText,
      String? suffixTest,
      bool isEnabled) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(1.h),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: TextField(
            enabled: isEnabled,
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
              prefix: prefixText != null ? Text(prefixText) : SizedBox(),
              suffix: suffixTest != null ? Text(suffixTest) : SizedBox(),
              hintText: "Enter Amount",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _showBankDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
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
          Obx(() => _bankNames("Bank Name", _controller.bankName)),
          SizedBox(
            height: 2.h,
          ),
          Obx(() => _bankNames("Bank Address", _controller.bankAddress)),
          SizedBox(
            height: 2.h,
          ),
          Obx(() => _bankNames("Account No", _controller.accountNo)),
          SizedBox(
            height: 2.h,
          ),
          Obx(() => _bankNames("Name", _controller.name)),
        ],
      ),
    );
  }

  Container _continue(String text, VoidCallback? voidCallback) {
    return Container(
      padding: EdgeInsets.all(3.h),
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
          child: _controller.isDepositSaved.value == true
              ? Text(text)
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  /*Container _continue(String text, VoidCallback voidCallback) {
    return Container(
      padding: EdgeInsets.all(3.h),
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
          child: Text(text),
        ),
      ),
    );
  }*/

  Text _bankNames(String initText, RxString text) {
    return Text(
      "$initText: ${text.value}",
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }

  /*Container _bankdropdown() {
    List<String> _bankNames = [];
    for (BankTransferModel banks in _bankDropDownList) {
      _bankNames.add(banks.bankName);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(1.h),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: DropdownButton<String>(
        hint: Text("Select Bank Account"),
        value: _bankDropDown.value,
        elevation: 16,
        isDense: false,
        isExpanded: true,
        underline: Container(
          color: Colors.transparent,
        ),
        style: TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          _bankDropDown.value = newValue!;
          for (BankTransferModel bank in _bankDropDownList) {
            if (bank.bankName == _bankDropDown.value) {
              _bankName.value = bank.bankName;
              _bankAddress.value = bank.bankAddress;
              _accountNo.value = bank.accountNo;
              _bankSwift.value = bank.bankSwift;
              _name.value = bank.name;
              _address.value = bank.address;
              _referenceNumber.value = bank.referenceNumber;
            }
          }
        },
        items: _bankNames.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }*/

  Widget _bankDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(1.h),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 1.8.h,
              horizontal: 2.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _controller.userDataList
                          .value[_controller.selectedIndex.value].bankName ??
                      "Name",
                  textAlign: TextAlign.start,
                ),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          onTap: () {
            Get.defaultDialog(
              title: "Select Card",
              content: Column(
                children: [
                  _controller.userDataList.value.length < 5
                      ? const SizedBox()
                      : Icon(Icons.arrow_drop_up_rounded),
                  SizedBox(
                    height:
                        _controller.userDataList.value.length < 5 ? 10.h : 35.h,
                    width: 50.h,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _controller.userDataList.value[index].bankName,
                          ),
                          onTap: () {
                            _controller.selectedIndex.value = index;
                            _controller.id.value = _controller
                                .userDataList.value[index].id
                                .toString();
                            _controller.bankName.value =
                                _controller.userDataList.value[index].bankName;
                            _controller.bankAddress.value = _controller
                                .userDataList.value[index].bankAddress
                                .toString();
                            _controller.accountNo.value = _controller
                                .userDataList.value[index].accountNo
                                .toString();
                            _controller.name.value = _controller
                                .userDataList.value[index].fullName
                                .toString();

                            Get.back();
                          },
                        );
                      },
                      itemCount: _controller.userDataList.value.length,
                    ),
                  ),
                  _controller.userDataList.value.length < 5
                      ? const SizedBox()
                      : Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
