import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/dashboard/currency_select/swap_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class CurrencySwapScreen extends StatelessWidget {
  final logger = Logger();
  final _controller = Get.put(SwapController());

  final int index;

  CurrencySwapScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.index.value = index;
    _controller.coinCode.value =
        _controller.dashboardValue.cryptoData[index].coinName.toLowerCase();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 1.h,
      ),
      child: Column(
        children: [
          _swap(context),
          SizedBox(
            height: 3.h,
          ),
          _continue(),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }

  Container _continue() {
    return Container(
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
            _controller.withdrawCrypto(index);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: _controller.isBought.value == true
                ? const Text("Continue")
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _swap(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.h),
      ),
      elevation: 0.5.h,
      child: Container(
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          children: [
            _converter(context),
            SizedBox(
              height: 3.h,
            ),
            _cryptoValueConvt(),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: double.infinity,
              child: Obx(
                () => Text(
                  "(Fee ${_controller.transactionFeeRate.value}${_controller.dashboardValue.wallet.currency})",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            _percent(),
            SizedBox(
              height: 3.h,
            ),
            _denominated(),
            SizedBox(
              height: 2.h,
            ),
            Obx(
              () => SizedBox(
                child: _controller.isTypeFinished.value == true
                    ? SizedBox()
                    : CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _percent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Percent",
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
            keyboardType: TextInputType.number,
            cursorColor: GlobalVals.appbarColor,
            controller: _controller.percentValue,
            decoration: InputDecoration(
              prefix: Text("%   "),
              hintText: "Percent Value",
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (text) {
              if (int.parse(text) <= 100) {
                Future.delayed(GlobalVals.duration, () {
                  if (text == _controller.percentValue.text) {
                    _controller.insertPercentage(_controller.percentValue.text);
                  }
                });
              } else {
                GlobalVals.errorToast("Percentage can't be more than 100");
              }
            },
          ),
        ),
        Row(
          children: [
            _percentButton("10%", "10"),
            _percentButton("25%", "25"),
            _percentButton("50%", "50"),
            _percentButton("75%", "75"),
            _percentButton("100%", "100"),
          ],
        )
      ],
    );
  }

  Widget _percentButton(String percent, String percentValue) {
    return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: () {
          _controller.percentValue.text = percentValue;
          _controller.insertPercentage(percentValue);
        },
        child: Text(
          percent,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Row _cryptoValueConvt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crypto Value",
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
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1.h),
                    bottomLeft: Radius.circular(1.h),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  cursorColor: GlobalVals.appbarColor,
                  controller: _controller.cryptoValueController,
                  decoration: InputDecoration(
                    prefix: Text("     "),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (text) {
                    Future.delayed(GlobalVals.duration, () {
                      if (text == _controller.cryptoValueController.text) {
                        _controller.insertValue(
                            _controller.cryptoValueController.text);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "To Crypto Value",
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(1.h),
                    bottomRight: Radius.circular(1.h),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  cursorColor: GlobalVals.appbarColor,
                  controller: _controller.amountController,
                  decoration: InputDecoration(
                    suffix: Text("     "),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
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
          "You Received Denominated Value",
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
            controller: _controller.denominatedValue,
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

  Column _cryptoValue(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      TextEditingController textEditingController,
      BorderRadius borderRadius,
      Color color,
      TextAlign textAlign) {
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
            textAlign: textAlign,
            cursorColor: GlobalVals.appbarColor,
            controller: textEditingController,
            decoration: InputDecoration(
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

  Row _converter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cryptocurrency",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(1.h),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 2.h, 2.h, 2.h),
                  child: Text(
                    _controller.dashboardValue.cryptoData[index].coinName,
                  ),
                ),
              )
            ],
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
          child: _dropDown(
            CrossAxisAlignment.end,
            "To Crypto",
            _controller.dropdownValueTo,
            _controller.dropDownValueToList.value,
            context,
          ),
        ),
      ],
    );
  }

  Widget _dropDown(
      CrossAxisAlignment crossAxisAlignment,
      String text,
      RxString dropdownInitValue,
      List<String> dropdownList,
      BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () => _controller.isCoinLoaded.value == true
                  ? const SizedBox()
                  : SizedBox(
                      height: 2.h,
                      width: 2.h,
                      child: const CircularProgressIndicator()),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 1.8.h,
                    bottom: 1.8.h,
                    left: 2.h,
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
                  logger.d("Pressed");
                  Get.defaultDialog(
                    title: "Select Crypto",
                    content: Column(
                      children: [
                        dropdownList.length < 5
                            ? const SizedBox()
                            : Icon(Icons.arrow_drop_up_rounded),
                        SizedBox(
                          height: dropdownList.length < 5 ? 10.h : 35.h,
                          width: 50.h,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  dropdownList[index].capitalizeFirst!,
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
                        dropdownList.length < 5
                            ? const SizedBox()
                            : Icon(Icons.arrow_drop_down_rounded),
                      ],
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
