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
  String result;

  factory SaveDepositModel.fromJson(Map<String, dynamic> json) => SaveDepositModel(
    code: json["code"],
    message: json["message"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result,
  };
}
