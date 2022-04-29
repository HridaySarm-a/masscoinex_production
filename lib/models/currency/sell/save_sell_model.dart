// To parse this JSON data, do
//
//     final saveSellModel = saveSellModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaveSellModel saveSellModelFromJson(String str) => SaveSellModel.fromJson(json.decode(str));

String saveSellModelToJson(SaveSellModel data) => json.encode(data.toJson());

class SaveSellModel {
  SaveSellModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  String result;

  factory SaveSellModel.fromJson(Map<String, dynamic> json) => SaveSellModel(
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
