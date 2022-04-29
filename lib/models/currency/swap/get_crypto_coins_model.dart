// To parse this JSON data, do
//
//     final getCryptoCoinsModel = getCryptoCoinsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCryptoCoinsModel getCryptoCoinsModelFromJson(String str) => GetCryptoCoinsModel.fromJson(json.decode(str));

String getCryptoCoinsModelToJson(GetCryptoCoinsModel data) => json.encode(data.toJson());

class GetCryptoCoinsModel {
  GetCryptoCoinsModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  GetCryptoCoinResult result;

  factory GetCryptoCoinsModel.fromJson(Map<String, dynamic> json) => GetCryptoCoinsModel(
    code: json["code"],
    message: json["message"],
    result: GetCryptoCoinResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class GetCryptoCoinResult {
  GetCryptoCoinResult({
    required this.status,
    required this.userCoinsList,
  });

  bool status;
  List<UserCoinsList> userCoinsList;

  factory GetCryptoCoinResult.fromJson(Map<String, dynamic> json) => GetCryptoCoinResult(
    status: json["status"],
    userCoinsList: List<UserCoinsList>.from(json["userCoinsList"].map((x) => UserCoinsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userCoinsList": List<dynamic>.from(userCoinsList.map((x) => x.toJson())),
  };
}

class UserCoinsList {
  UserCoinsList({
    required this.coinName,
    required this.coinCode,
  });

  String coinName;
  String coinCode;

  factory UserCoinsList.fromJson(Map<String, dynamic> json) => UserCoinsList(
    coinName: json["coin_name"],
    coinCode: json["coin_code"],
  );

  Map<String, dynamic> toJson() => {
    "coin_name": coinName,
    "coin_code": coinCode,
  };
}
