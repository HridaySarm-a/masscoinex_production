// To parse this JSON data, do
//
//     final currencySaveModel = currencySaveModelFromJson(jsonString);

import 'dart:convert';

CurrencySaveModel currencySaveModelFromJson(String str) => CurrencySaveModel.fromJson(json.decode(str));

String currencySaveModelToJson(CurrencySaveModel data) => json.encode(data.toJson());

class CurrencySaveModel {
  CurrencySaveModel({
    this.code,
    this.message,
    this.result,
  });

  String? code;
  String? message;
  String? result;

  factory CurrencySaveModel.fromJson(Map<String, dynamic> json) => CurrencySaveModel(
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
