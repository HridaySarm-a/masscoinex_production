// To parse this JSON data, do
//
//     final addCardDocumentFieldsModel = addCardDocumentFieldsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddCardDocumentFieldsModel addCardDocumentFieldsModelFromJson(String str) => AddCardDocumentFieldsModel.fromJson(json.decode(str));

String addCardDocumentFieldsModelToJson(AddCardDocumentFieldsModel data) => json.encode(data.toJson());

class AddCardDocumentFieldsModel {
  AddCardDocumentFieldsModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  String result;

  factory AddCardDocumentFieldsModel.fromJson(Map<String, dynamic> json) => AddCardDocumentFieldsModel(
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
