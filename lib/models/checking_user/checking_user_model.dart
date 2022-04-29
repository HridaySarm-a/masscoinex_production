// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:masscoinex/models/checking_user/result_error_model.dart';
import 'package:masscoinex/models/checking_user/result_model.dart';

CheckUserModel checkUserModelFromJson(String str) =>
    CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  String code;
  String message;
  Result? result;
  ResultError? resultError;
  CheckUserModel({
    required this.code,
    required this.message,
    this.result,
    this.resultError,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
        code: json["code"],
        message: json["message"],
      );
  factory CheckUserModel.fromJsonSuccess(Map<String, dynamic> json) => CheckUserModel(
        code: json["code"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );
  factory CheckUserModel.fromJsonError(Map<String, dynamic> json) => CheckUserModel(
        code: json["code"],
        message: json["message"],
        resultError: ResultError.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": code == "1"? result!.toJson(): resultError!.toJson(),
      };
}
