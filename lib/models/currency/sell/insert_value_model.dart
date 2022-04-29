// To parse this JSON data, do
//
//     final insertValueModel = insertValueModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

InsertValueModel insertValueModelFromJson(String str) => InsertValueModel.fromJson(json.decode(str));

String insertValueModelToJson(InsertValueModel data) => json.encode(data.toJson());

class InsertValueModel {
  InsertValueModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  InsertValueResult result;

  factory InsertValueModel.fromJson(Map<String, dynamic> json) => InsertValueModel(
    code: json["code"],
    message: json["message"],
    result: InsertValueResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class InsertValueResult {
  InsertValueResult({
    required this.status,
    required this.message,
    required this.afterInitialRateFeeValue,
    required this.userCoinAmountAfterFees,
    required this.coinSellTransactionRate,
    required this.coinSellTransactionVolumeFees,
    required this.userCoinAmount,
  });

  bool status;
  String message;
  int afterInitialRateFeeValue;
  String userCoinAmountAfterFees;
  int coinSellTransactionRate;
  String coinSellTransactionVolumeFees;
  String userCoinAmount;

  factory InsertValueResult.fromJson(Map<String, dynamic> json) => InsertValueResult(
    status: json["status"],
    message: json["message"],
    afterInitialRateFeeValue: json["afterInitialRateFeeValue"],
    userCoinAmountAfterFees: json["userCoinAmountAfterFees"],
    coinSellTransactionRate: json["coin_sell_transaction_rate"],
    coinSellTransactionVolumeFees: json["coin_sell_transaction_volume_fees"],
    userCoinAmount: json["userCoinAmount"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "afterInitialRateFeeValue": afterInitialRateFeeValue,
    "userCoinAmountAfterFees": userCoinAmountAfterFees,
    "coin_sell_transaction_rate": coinSellTransactionRate,
    "coin_sell_transaction_volume_fees": coinSellTransactionVolumeFees,
    "userCoinAmount": userCoinAmount,
  };
}
