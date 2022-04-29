import 'package:flutter/material.dart';
import 'package:masscoinex/controllers/fiat/fiat_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class FiatDepositScreen extends StatelessWidget {
  final FiatController controller;
  FiatDepositScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.h,
      ),
      child: Column(
        children: [
          _converter(),
          SizedBox(
            height: 2.h,
          ),
          _cryptoValueConvt(),
          SizedBox(
            height: 2.h,
          ),
          _denominated(),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => SizedBox(
              child: controller.isTypeFinished.value == true
                  ? SizedBox()
                  : CircularProgressIndicator(),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          _buttons(),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }

  Row _buttons() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _continue(
            "Continue",
            /*() => Get.toNamed(Routes.modeOfPayment),*/
            () => controller.deposit(),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          flex: 1,
          child: _continue("Back", () {
            print(controller.fiatIndex.value);
            controller.fiatIndex.value = 0;
          }),
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
              "Transaction Fee",
              controller.transactionFeeController,
              BorderRadius.circular(1.h),
              Colors.grey.shade200,
              TextAlign.start,
              null,
              ""),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 1,
          child: _cryptoValue(
              CrossAxisAlignment.end,
              "Transaction Fee Rate",
              controller.transactionFeeRateController,
              BorderRadius.circular(1.h),
              Colors.grey.shade200,
              TextAlign.end,
              "",
              null),
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
            keyboardType: TextInputType.number,
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
            onChanged: (text) {
              Future.delayed(GlobalVals.duration, () {
                if (text == controller.amountController.text) {
                  controller.insertValue(controller.amountController.text);
                }
              });
            },
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

  Column _denominated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pay Amount",
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
            enabled: false,
            cursorColor: GlobalVals.appbarColor,
            controller: controller.payAmountController,
            decoration: InputDecoration(
              hintText: "Denomitated Value",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
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
            controller.amountController,
            null,
            "",
            true,
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
            controller.currencyController,
            "",
            null,
            false,
          ),
        ),
      ],
    );
  }
  Container _continue(String text, VoidCallback voidCallback) {
    return Container(
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
          child: text == "Continue"
              ? Obx(() {
                  return controller.hasDepositSaved.value == true
                      ? Text(text)
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        );
                })
              : Text(text),
        ),
      ),
    );
  }
  Widget _dropDown(CrossAxisAlignment crossAxisAlignment, String text,
      RxString dropdownInitValue, List<String> dropdownList) {
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
        Obx(
              () => Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(1.h),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: /* DropdownButton<String>(
              value: dropdownInitValue.value,
              elevation: 16,
              isDense: false,
              isExpanded: true,
              underline: Container(
                color: Colors.transparent,
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                dropdownInitValue.value = newValue!;
              },
              items: dropdownList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ), */
            Material(
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
                        dropdownInitValue.value,
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
                    title: "Select Crypto",
                    content: Container(
                      height: 35.h,
                      width: 100.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              dropdownList[index],
                            ),
                            onTap: () {
                              dropdownInitValue.value = dropdownList[index];
                              Get.back();
                            },
                          );
                        },
                        itemCount: dropdownList.length,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

}
