// To parse this JSON data, do
//
//     final buyAmountToValueModel = buyAmountToValueModelFromJson(jsonString);

import 'dart:convert';

BuyAmountToValueModel buyAmountToValueModelFromJson(String str) =>
    BuyAmountToValueModel.fromJson(json.decode(str));

String buyAmountToValueModelToJson(BuyAmountToValueModel data) =>
    json.encode(data.toJson());

class BuyAmountToValueModel {
  String code;
  String message;
  Result result;
  BuyAmountToValueModel({
    required this.code,
    required this.message,
    required this.result,
  });

  factory BuyAmountToValueModel.fromJson(Map<String, dynamic> json) =>
      BuyAmountToValueModel(
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
  dynamic cryptoValue;
  String message;
  String walletAmount;
  dynamic receivedCoinValue;
  dynamic transactionFee;
  dynamic coinBuyTransactionRate;
  Result({
    required this.status,
    required this.actualCoinValue,
    required this.cryptoValue,
    required this.message,
    required this.walletAmount,
    required this.receivedCoinValue,
    required this.transactionFee,
    required this.coinBuyTransactionRate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        actualCoinValue: json["actualCoinValue"],
        cryptoValue: json["crypto_value"],
        message: json["message"],
        walletAmount: json["walletAmount"],
        receivedCoinValue: json["received_coin_value"],
        transactionFee: json["transaction_fee"],
        coinBuyTransactionRate: json["coin_buy_transaction_rate"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "actualCoinValue": actualCoinValue,
        "crypto_value": cryptoValue,
        "message": message,
        "walletAmount": walletAmount,
        "received_coin_value": receivedCoinValue,
        "transaction_fee": transactionFee,
        "coin_buy_transaction_rate": coinBuyTransactionRate,
      };
}
