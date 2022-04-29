// To parse this JSON data, do
//
//     final sellPercentModel = sellPercentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SellPercentModel sellPercentModelFromJson(String str) => SellPercentModel.fromJson(json.decode(str));

String sellPercentModelToJson(SellPercentModel data) => json.encode(data.toJson());

class SellPercentModel {
  SellPercentModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  SellPercentageResult result;

  factory SellPercentModel.fromJson(Map<String, dynamic> json) => SellPercentModel(
    code: json["code"],
    message: json["message"],
    result: SellPercentageResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class SellPercentageResult {
  SellPercentageResult({
    required this.status,
    required this.message,
    required this.afterInitialRateFeeValue,
    required this.cryptoValue,
    required this.userCoinAmountAfterFees,
    required this.coinSellTransactionRate,
    required this.coinSellTransactionVolumeFees,
    required this.userCoinAmount,
  });

  bool status;
  String message;
  dynamic afterInitialRateFeeValue;
  dynamic cryptoValue;
  dynamic userCoinAmountAfterFees;
  dynamic coinSellTransactionRate;
  dynamic coinSellTransactionVolumeFees;
  dynamic userCoinAmount;

  factory SellPercentageResult.fromJson(Map<String, dynamic> json) => SellPercentageResult(
    status: json["status"],
    message: json["message"],
    afterInitialRateFeeValue: json["afterInitialRateFeeValue"],
    cryptoValue: json["crypto_value"],
    userCoinAmountAfterFees: json["userCoinAmountAfterFees"],
    coinSellTransactionRate: json["coin_sell_transaction_rate"],
    coinSellTransactionVolumeFees: json["coin_sell_transaction_volume_fees"],
    userCoinAmount: json["userCoinAmount"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "afterInitialRateFeeValue": afterInitialRateFeeValue,
    "crypto_value": cryptoValue,
    "userCoinAmountAfterFees": userCoinAmountAfterFees,
    "coin_sell_transaction_rate": coinSellTransactionRate,
    "coin_sell_transaction_volume_fees": coinSellTransactionVolumeFees,
    "userCoinAmount": userCoinAmount,
  };
}
