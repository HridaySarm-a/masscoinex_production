// To parse this JSON data, do
//
//     final addCardFieldsModel = addCardFieldsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddCardFieldsModel addCardFieldsModelFromJson(String str) => AddCardFieldsModel.fromJson(json.decode(str));

String addCardFieldsModelToJson(AddCardFieldsModel data) => json.encode(data.toJson());

class AddCardFieldsModel {
  AddCardFieldsModel({
    required this.code,
    required this.message,
  });

  String code;
  String message;

  factory AddCardFieldsModel.fromJson(Map<String, dynamic> json) => AddCardFieldsModel(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
