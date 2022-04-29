// To parse this JSON data, do
//
//     final insertAmountModel = insertAmountModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

InsertAmountModel insertAmountModelFromJson(String str) => InsertAmountModel.fromJson(json.decode(str));

String insertAmountModelToJson(InsertAmountModel data) => json.encode(data.toJson());

class InsertAmountModel {
  InsertAmountModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  InsertAmountResult result;

  factory InsertAmountModel.fromJson(Map<String, dynamic> json) => InsertAmountModel(
    code: json["code"],
    message: json["message"],
    result: InsertAmountResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class InsertAmountResult {
  InsertAmountResult({
    required this.status,
    required this.message,
    required this.cryptoAmount,
    required this.userCoinAmountAfterFees,
    required this.coinSellTransactionRate,
    required this.coinSellTransactionVolumeFees,
    required this.userCoinAmount,
  });

  bool status;
  String message;
  dynamic cryptoAmount;
    dynamic userCoinAmountAfterFees;
  int coinSellTransactionRate;
  dynamic coinSellTransactionVolumeFees;
  dynamic userCoinAmount;

  factory InsertAmountResult.fromJson(Map<String, dynamic> json) => InsertAmountResult(
    status: json["status"],
    message: json["message"],
    cryptoAmount: json["crypto_amount"],
    userCoinAmountAfterFees: json["userCoinAmountAfterFees"],
    coinSellTransactionRate: json["coin_sell_transaction_rate"],
    coinSellTransactionVolumeFees: json["coin_sell_transaction_volume_fees"],
    userCoinAmount: json["userCoinAmount"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "crypto_amount": cryptoAmount,
    "userCoinAmountAfterFees": userCoinAmountAfterFees,
    "coin_sell_transaction_rate": coinSellTransactionRate,
    "coin_sell_transaction_volume_fees": coinSellTransactionVolumeFees,
    "userCoinAmount": userCoinAmount,
  };
}
