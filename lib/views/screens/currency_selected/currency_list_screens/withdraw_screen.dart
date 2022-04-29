import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/dashboard/currency_select/withdraw_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WithdrawScreen extends StatelessWidget {
  final _logger = Logger();
  final _controller = Get.put(WithdrawController());
  final int index;
  WithdrawScreen({Key? key, required this.index}) : super(key: key);

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
          _swap(),
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

  Widget _swap() {
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
            _converter(),
            SizedBox(
              height: 3.h,
            ),
            _cryptoValueConvt(),
            /* Obx(
              () => _cryptoValueConvt(),
            ), */
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

  Column _percent() {
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
                    _logger.d(_controller.amountController.text);
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
        ),
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

  Column _denominated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Receiving Crypto Value",
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
                  enabled: false,
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
                    /*Future.delayed(GlobalVals.duration, () {
                      if (text == _controller.cryptoValueController.text) {
                        _controller.insertValue(
                            _controller.cryptoValueController.text);
                        _logger.d(_controller.cryptoValueController.text);
                      }
                    });*/
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
                "Amount",
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
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  cursorColor: GlobalVals.appbarColor,
                  controller: _controller.amountController,
                  decoration: InputDecoration(
                    suffix: Text(
                        "${_controller.dashboardValue.wallet.currency}        "),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (text) {
                    Future.delayed(GlobalVals.duration, () {
                      if (text == _controller.amountController.text) {
                        _controller
                            .insertAmount(_controller.amountController.text);
                        _logger.d(_controller.amountController.text);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _converter() {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Selected Currency",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(1.h),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 2.h, 0, 2.h),
                  child: Text(
                    _controller.selectedCurrency.value,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _continue() {
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
            _controller.saveWithdraw(index);
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
}
