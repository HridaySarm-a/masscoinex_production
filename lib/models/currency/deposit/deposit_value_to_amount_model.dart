// To parse this JSON data, do
//
//     final saveDepositModel = saveDepositModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaveDepositModel saveDepositModelFromJson(String str) => SaveDepositModel.fromJson(json.decode(str));

String saveDepositModelToJson(SaveDepositModel data) => json.encode(data.toJson());

class SaveDepositModel {
  SaveDepositModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  DepositValueToAmountResult result;

  factory SaveDepositModel.fromJson(Map<String, dynamic> json) => SaveDepositModel(
    code: json["code"],
    message: json["message"],
    result: DepositValueToAmountResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class DepositValueToAmountResult {
  DepositValueToAmountResult({
    required this.coinName,
    required this.cryptoAmount,
    required this.cryptoValue,
    required this.transactionFeeRate,
    required this.transactionFee,
    required this.receivedCoinValue,
  });

  String coinName;
  String cryptoAmount;
  String cryptoValue;
  int transactionFeeRate;
  String transactionFee;
  String receivedCoinValue;

  factory DepositValueToAmountResult.fromJson(Map<String, dynamic> json) => DepositValueToAmountResult(
    coinName: json["coin_name"],
    cryptoAmount: json["crypto_amount"],
    cryptoValue: json["crypto_value"],
    transactionFeeRate: json["transaction_fee_rate"],
    transactionFee: json["transaction_fee"],
    receivedCoinValue: json["received_coin_value"],
  );

  Map<String, dynamic> toJson() => {
    "coin_name": coinName,
    "crypto_amount": cryptoAmount,
    "crypto_value": cryptoValue,
    "transaction_fee_rate": transactionFeeRate,
    "transaction_fee": transactionFee,
    "received_coin_value": receivedCoinValue,
  };
}
