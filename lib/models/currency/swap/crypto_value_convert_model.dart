// To parse this JSON data, do
//
//     final cryptoValueConvertModel = cryptoValueConvertModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CryptoValueConvertModel cryptoValueConvertModelFromJson(String str) => CryptoValueConvertModel.fromJson(json.decode(str));

String cryptoValueConvertModelToJson(CryptoValueConvertModel data) => json.encode(data.toJson());

class CryptoValueConvertModel {
  CryptoValueConvertModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  CryptoValueConvertResult result;

  factory CryptoValueConvertModel.fromJson(Map<String, dynamic> json) => CryptoValueConvertModel(
    code: json["code"],
    message: json["message"],
    result: CryptoValueConvertResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class CryptoValueConvertResult {
  CryptoValueConvertResult({
    required this.message,
    required this.selectedCoinWalletValue,
    required this.volumeOfCoin,
    required this.actualVolumeOfCoinUserGet,
    required this.coinBuyTransactionRate,
  });

  String message;
  String selectedCoinWalletValue;
  String volumeOfCoin;
  String actualVolumeOfCoinUserGet;
  dynamic coinBuyTransactionRate;

  factory CryptoValueConvertResult.fromJson(Map<String, dynamic> json) => CryptoValueConvertResult(
    message: json["message"],
    selectedCoinWalletValue: json["selectedCoinWalletValue"],
    volumeOfCoin: json["volume_of_coin"],
    actualVolumeOfCoinUserGet: json["actual_volume_of_coin_user_get"],
    coinBuyTransactionRate: json["coin_buy_transaction_rate"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "selectedCoinWalletValue": selectedCoinWalletValue,
    "volume_of_coin": volumeOfCoin,
    "actual_volume_of_coin_user_get": actualVolumeOfCoinUserGet,
    "coin_buy_transaction_rate": coinBuyTransactionRate,
  };
}
