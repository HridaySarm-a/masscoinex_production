// To parse this JSON data, do
//
//     final buyPercentModel = buyPercentModelFromJson(jsonString);
import 'dart:convert';

BuyPercentModel buyPercentModelFromJson(String str) => BuyPercentModel.fromJson(json.decode(str));

String buyPercentModelToJson(BuyPercentModel data) => json.encode(data.toJson());

class BuyPercentModel {
  BuyPercentModel({
    required this.code,
    required this.message,
    required this.result,
  });

  dynamic code;
  String message;
  Result result;

  factory BuyPercentModel.fromJson(Map<String, dynamic> json) => BuyPercentModel(
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
  Result({
    required this.the0,
    required this.status,
    required this.actualCoinValue,
    required this.cryptoValue,
    required this.message,
    required this.walletAmount,
    required this.receivedCoinValue,
    required this.transactionFee,
    required this.coinBuyTransactionRate,
  });

  int the0;
  bool status;
  String actualCoinValue;
  String cryptoValue;
  String message;
  double walletAmount;
  String receivedCoinValue;
  String transactionFee;
  int coinBuyTransactionRate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    the0: json["0"],
    status: json["status"],
    actualCoinValue: json["actualCoinValue"],
    cryptoValue: json["crypto_value"],
    message: json["message"],
    walletAmount: json["walletAmount"].toDouble(),
    receivedCoinValue: json["received_coin_value"],
    transactionFee: json["transaction_fee"],
    coinBuyTransactionRate: json["coin_buy_transaction_rate"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
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
