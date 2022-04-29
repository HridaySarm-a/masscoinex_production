// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

import 'package:masscoinex/models/register_user/register_result.dart';
import 'package:masscoinex/models/register_user/register_result_error.dart';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String code;
  String message;
  RegisterResult? registerResult;
  RegisterResultError? registerResultError;
  RegisterModel({
    required this.code,
    required this.message,
    this.registerResult,
    this.registerResultError,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        code: json["code"],
        message: json["message"],
      );
  factory RegisterModel.fromJsonError(Map<String, dynamic> json) =>
      RegisterModel(
        code: json["code"],
        message: json["message"],
        registerResultError: RegisterResultError.fromJson(json["result"]),
      );
  factory RegisterModel.fromJsonSuccess(Map<String, dynamic> json) =>
      RegisterModel(
        code: json["code"],
        message: json["message"],
        registerResult: RegisterResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": code == "0"
            ? registerResultError!.toJson()
            : registerResult!.toJson(),
      };
}
