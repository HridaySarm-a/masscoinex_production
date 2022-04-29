// To parse this JSON data, do
//
//     final swapPercentModel = swapPercentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SwapPercentModel swapPercentModelFromJson(String str) => SwapPercentModel.fromJson(json.decode(str));

String swapPercentModelToJson(SwapPercentModel data) => json.encode(data.toJson());

class SwapPercentModel {
  SwapPercentModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  SwapPercentResult result;

  factory SwapPercentModel.fromJson(Map<String, dynamic> json) => SwapPercentModel(
    code: json["code"],
    message: json["message"],
    result: SwapPercentResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class SwapPercentResult {
  SwapPercentResult({
    required this.selectedCoinWalletValue,
    required this.volumeOfCoin,
    required this.actualVolumeOfCoinUserGet,
    required this.coinBuyTransactionRate,
  });

  dynamic selectedCoinWalletValue;
  dynamic volumeOfCoin;
  dynamic actualVolumeOfCoinUserGet;
  dynamic coinBuyTransactionRate;

  factory SwapPercentResult.fromJson(Map<String, dynamic> json) => SwapPercentResult(
    selectedCoinWalletValue: json["selectedCoinWalletValue"],
    volumeOfCoin: json["volume_of_coin"],
    actualVolumeOfCoinUserGet: json["actual_volume_of_coin_user_get"],
    coinBuyTransactionRate: json["coin_buy_transaction_rate"],
  );

  Map<String, dynamic> toJson() => {
    "selectedCoinWalletValue": selectedCoinWalletValue,
    "volume_of_coin": volumeOfCoin,
    "actual_volume_of_coin_user_get": actualVolumeOfCoinUserGet,
    "coin_buy_transaction_rate": coinBuyTransactionRate,
  };
}
