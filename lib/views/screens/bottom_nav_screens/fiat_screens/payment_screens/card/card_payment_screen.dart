import 'package:flutter/material.dart';
import 'package:masscoinex/controllers/fiat/payment_method/card_payment_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/bank_transfer_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class CardPaymentScreen extends StatelessWidget {
  final _controller = Get.put(CardPaymentController());
  final String paymentMode;

  CardPaymentScreen({Key? key, required this.paymentMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.getDepositInfoForUpi();
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Payment"),
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
            Obx(() => _controller.userDataList.length != 0
                ? _bankDropdown()
                : SizedBox()),
            SizedBox(
              height: 2.h,
            ),
            _creditCardView(),
            SizedBox(
              height: 3.h,
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

  Container _creditCardView() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.h),
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/card.jpg",
          ),
          Positioned(
            top: 2.h,
            left: 3.h,
            child: Obx(() {
              return Text(
                _controller.cardType.value,
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sp,
                ),
              );
            }),
          ),
          Obx(
            () => Positioned(
              top: 15.h,
              left: 6.h,
              child: Text(
                _controller.accountNo.value,
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  letterSpacing: 0.3.h,
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              top: 21.h,
              left: 3.h,
              child: Text(
                _controller.ownerName.value,
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
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

  /*Container _bankDropdown() {
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
        value: _controller.bankDropDown.value,
        elevation: 16,
        isDense: false,
        isExpanded: true,
        underline: Container(
          color: Colors.transparent,
        ),
        style: TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          _controller.bankDropDown.value = newValue!;
          for (var bank in _controller.userDataList) {
            if (bank.nameOnCard == _controller.userDataList.value) {
              _controller.id.value = bank.id;
              _controller.accountNo.value = bank.cardNumber;
              _controller.ownerName.value = bank.nameOnCard;
              _controller.cardType.value = bank.cardType;
            }
          }
        },
        items:
            _controller.bankNames.map<DropdownMenuItem<String>>((String value) {
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
                          .value[_controller.selectedIndex.value].nameOnCard ??
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
                            _controller.userDataList.value[index].nameOnCard,
                          ),
                          onTap: () {
                            _controller.selectedIndex.value = index;
                            _controller.id.value = _controller
                                .userDataList.value[index].id
                                .toString();
                            _controller.ownerName.value = _controller
                                .userDataList.value[index].nameOnCard;
                            _controller.cardNumber.value = _controller
                                .userDataList.value[index].cardNumber
                                .toString();
                            _controller.accountNo.value = _controller
                                .userDataList.value[index].cardNumber
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

  Row _converter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: _amountAndCurrency(
            CrossAxisAlignment.start,
            "Amount to Deposit",
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

  Row _cryptoValueConvt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: _cryptoValue(
            CrossAxisAlignment.start,
            "Deposit Fee",
            _controller.depositFeeController,
            BorderRadius.circular(1.h),
            Colors.grey.shade200,
            TextAlign.start,
            null,
            "",
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 1,
          child: _cryptoValue(
            CrossAxisAlignment.end,
            "Deposit Amount",
            _controller.depositAmountController,
            BorderRadius.circular(1.h),
            Colors.grey.shade200,
            TextAlign.end,
            "",
            null,
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

  Widget _upiView() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            _converter(),
            SizedBox(
              height: 2.h,
            ),
            _cryptoValueConvt(),
          ],
        ),
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
}
