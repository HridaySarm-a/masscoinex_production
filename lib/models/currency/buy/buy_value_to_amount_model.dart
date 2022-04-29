// To parse this JSON data, do
//
//     final buyValueToAmountModel = buyValueToAmountModelFromJson(jsonString);

import 'dart:convert';

BuyValueToAmountModel buyValueToAmountModelFromJson(String str) =>
    BuyValueToAmountModel.fromJson(json.decode(str));

String buyValueToAmountModelToJson(BuyValueToAmountModel data) =>
    json.encode(data.toJson());

class BuyValueToAmountModel {
  int code;
  String message;
  Result result;
  BuyValueToAmountModel({
    required this.code,
    required this.message,
    required this.result,
  });

  factory BuyValueToAmountModel.fromJson(Map<String, dynamic> json) =>
      BuyValueToAmountModel(
        code: json["code"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result.toJson(),
      };
}

class Result {
  bool status;
  dynamic actualCoinValue;
  String message;
  dynamic walletAmount;
  dynamic cryptoAmount;
  dynamic receivedCoinValue;
  dynamic transactionFee;
  dynamic coinBuyTransactionRate;
  Result({
    required this.status,
    required this.actualCoinValue,
    required this.message,
    required this.walletAmount,
    required this.cryptoAmount,
    required this.receivedCoinValue,
    required this.transactionFee,
    required this.coinBuyTransactionRate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        actualCoinValue: json["actualCoinValue"],
        message: json["message"],
        walletAmount: json["walletAmount"],
        cryptoAmount: json["crypto_amount"],
        receivedCoinValue: json["received_coin_value"],
        transactionFee: json["transaction_fee"],
        coinBuyTransactionRate: json["coin_buy_transaction_rate"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "actualCoinValue": actualCoinValue,
        "message": message,
        "walletAmount": walletAmount,
        "crypto_amount": cryptoAmount,
        "received_coin_value": receivedCoinValue,
        "transaction_fee": transactionFee,
        "coin_buy_transaction_rate": coinBuyTransactionRate,
      };
}
