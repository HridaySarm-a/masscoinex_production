// To parse this JSON data, do
//
//     final saveWithdraw = saveWithdrawFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaveWithdraw saveWithdrawFromJson(String str) => SaveWithdraw.fromJson(json.decode(str));

String saveWithdrawToJson(SaveWithdraw data) => json.encode(data.toJson());

class SaveWithdraw {
  SaveWithdraw({
    required this.code,
    required this.message,
  });

  String code;
  String message;

  factory SaveWithdraw.fromJson(Map<String, dynamic> json) => SaveWithdraw(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
