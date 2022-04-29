// To parse this JSON data, do
//
//     final depositModel = depositModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DepositModel depositModelFromJson(String str) => DepositModel.fromJson(json.decode(str));

String depositModelToJson(DepositModel data) => json.encode(data.toJson());

class DepositModel {
  DepositModel({
    required this.code,
    required this.message,
    required this.userCode,
    required this.amount,
    required this.depositFee,
    required this.depositAmount,
    required this.currency,
  });

  String code;
  String message;
  String userCode;
  String amount;
  int depositFee;
  int depositAmount;
  String currency;

  factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
    code: json["code"],
    message: json["message"],
    userCode: json["user_code"],
    amount: json["amount"],
    depositFee: json["depositFee"],
    depositAmount: json["deposit_amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "user_code": userCode,
    "amount": amount,
    "depositFee": depositFee,
    "deposit_amount": depositAmount,
    "currency": currency,
  };
}
