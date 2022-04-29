// To parse this JSON data, do
//
//     final depositErrorModel = depositErrorModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DepositErrorModel depositErrorModelFromJson(String str) => DepositErrorModel.fromJson(json.decode(str));

String depositErrorModelToJson(DepositErrorModel data) => json.encode(data.toJson());

class DepositErrorModel {
  DepositErrorModel({
    required this.code,
    required this.message,
  });

  String code;
  String message;

  factory DepositErrorModel.fromJson(Map<String, dynamic> json) => DepositErrorModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
