// To parse this JSON data, do
//
//     final addCardFieldsModel = addCardFieldsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddCardFieldsSuccessModel addCardFieldsSuccessModelFromJson(String str) =>
    AddCardFieldsSuccessModel.fromJson(json.decode(str));

String addCardFieldsModelToJson(AddCardFieldsSuccessModel data) =>
    json.encode(data.toJson());

class AddCardFieldsSuccessModel {
  AddCardFieldsSuccessModel({
    required this.code,
    required this.message,
    required this.result,
  });

  String code;
  String message;
  AddCardFieldResult result;

  factory AddCardFieldsSuccessModel.fromJson(Map<String, dynamic> json) =>
      AddCardFieldsSuccessModel(
        code: json["code"],
        message: json["message"],
        result: AddCardFieldResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result.toJson(),
      };
}

class AddCardFieldResult {
  AddCardFieldResult({
    required this.cardId,
  });

  int cardId;

  factory AddCardFieldResult.fromJson(Map<String, dynamic> json) => AddCardFieldResult(
        cardId: json["card_id"],
      );

  Map<String, dynamic> toJson() => {
        "card_id": cardId,
      };
}
