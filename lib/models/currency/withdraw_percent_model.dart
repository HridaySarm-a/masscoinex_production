// To parse this JSON data, do
//
//     final withdrawPercentModel = withdrawPercentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WithdrawPercentModel withdrawPercentModelFromJson(String str) => WithdrawPercentModel.fromJson(json.decode(str));

String withdrawPercentModelToJson(WithdrawPercentModel data) => json.encode(data.toJson());

class WithdrawPercentModel {
  WithdrawPercentModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  WithdrawPercentResult result;

  factory WithdrawPercentModel.fromJson(Map<String, dynamic> json) => WithdrawPercentModel(
    code: json["code"],
    message: json["message"],
    result: WithdrawPercentResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class WithdrawPercentResult {
  WithdrawPercentResult({
    required this.address,
    required this.coinName,
    required this.cryptoAmount,
    required this.cryptoValue,
    required this.transactionFeeRate,
    required this.transactionFee,
    required this.receivedCoinValue,
  });

  String address;
  String coinName;
  String cryptoAmount;
  String cryptoValue;
  int transactionFeeRate;
  String transactionFee;
  String receivedCoinValue;

  factory WithdrawPercentResult.fromJson(Map<String, dynamic> json) => WithdrawPercentResult(
    address: json["address"],
    coinName: json["coin_name"],
    cryptoAmount: json["crypto_amount"],
    cryptoValue: json["crypto_value"],
    transactionFeeRate: json["transaction_fee_rate"],
    transactionFee: json["transaction_fee"],
    receivedCoinValue: json["received_coin_value"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "coin_name": coinName,
    "crypto_amount": cryptoAmount,
    "crypto_value": cryptoValue,
    "transaction_fee_rate": transactionFeeRate,
    "transaction_fee": transactionFee,
    "received_coin_value": receivedCoinValue,
  };
}
