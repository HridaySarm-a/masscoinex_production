// To parse this JSON data, do
//
//     final modeOfPaymentModel = modeOfPaymentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModeOfPaymentModel modeOfPaymentModelFromJson(String str) => ModeOfPaymentModel.fromJson(json.decode(str));

String modeOfPaymentModelToJson(ModeOfPaymentModel data) => json.encode(data.toJson());

class ModeOfPaymentModel {
  ModeOfPaymentModel({
    required this.code,
    required this.message,
    required this.modeData,
  });

  String code;
  String message;
  List<ModeDatum> modeData;

  factory ModeOfPaymentModel.fromJson(Map<String, dynamic> json) => ModeOfPaymentModel(
    code: json["code"],
    message: json["message"],
    modeData: List<ModeDatum>.from(json["mode_data"].map((x) => ModeDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "mode_data": List<dynamic>.from(modeData.map((x) => x.toJson())),
  };
}

class ModeDatum {
  ModeDatum({
    required this.payModeName,
    required this.payModeValue,
    required this.description,
  });

  String payModeName;
  String payModeValue;
  String description;

  factory ModeDatum.fromJson(Map<String, dynamic> json) => ModeDatum(
    payModeName: json["pay_mode_name"],
    payModeValue: json["pay_mode_value"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "pay_mode_name": payModeName,
    "pay_mode_value": payModeValue,
    "description": description,
  };
}
