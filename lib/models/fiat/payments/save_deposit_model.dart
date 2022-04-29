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
    required this.paymentMode,
    required this.loginUrl,
  });

  String code;
  String message;
  String paymentMode;
  dynamic loginUrl;

  factory SaveDepositModel.fromJson(Map<String, dynamic> json) => SaveDepositModel(
    code: json["code"],
    message: json["message"],
    paymentMode: json["payment_mode"],
    loginUrl: json["login_url"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "payment_mode": paymentMode,
    "login_url": loginUrl,
  };
}
