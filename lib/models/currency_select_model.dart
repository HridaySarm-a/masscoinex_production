// To parse this JSON data, do
//
//     final currencySelectModel = currencySelectModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CurrencySelectModel currencySelectModelFromJson(String str) => CurrencySelectModel.fromJson(json.decode(str));

String currencySelectModelToJson(CurrencySelectModel data) => json.encode(data.toJson());

class CurrencySelectModel {
  CurrencySelectModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  List<CurrencyResult> result;

  factory CurrencySelectModel.fromJson(Map<String, dynamic> json) => CurrencySelectModel(
    code: json["code"],
    message: json["message"],
    result: List<CurrencyResult>.from(json["result"].map((x) => CurrencyResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class CurrencyResult {
  CurrencyResult({
    required this.currencyName,
    required this.currencyCode,
    required this.currencyImage,
    required this.currencyImagePath,
  });

  String currencyName;
  String currencyCode;
  String currencyImage;
  String currencyImagePath;

  factory CurrencyResult.fromJson(Map<String, dynamic> json) => CurrencyResult(
    currencyName: json["currency_name"],
    currencyCode: json["currency_code"],
    currencyImage: json["currency_image"],
    currencyImagePath: json["currency_image_path"],
  );

  Map<String, dynamic> toJson() => {
    "currency_name": currencyName,
    "currency_code": currencyCode,
    "currency_image": currencyImage,
    "currency_image_path": currencyImagePath,
  };
}
