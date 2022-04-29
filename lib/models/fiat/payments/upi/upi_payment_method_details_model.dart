// To parse this JSON data, do
//
//     final upiPaymentMethodDetailsModel = upiPaymentMethodDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpiPaymentMethodDetailsModel upiPaymentMethodDetailsModelFromJson(String str) => UpiPaymentMethodDetailsModel.fromJson(json.decode(str));

String upiPaymentMethodDetailsModelToJson(UpiPaymentMethodDetailsModel data) => json.encode(data.toJson());

class UpiPaymentMethodDetailsModel {
  UpiPaymentMethodDetailsModel({
    required this.code,
    required this.message,
    required this.modeDataFields,
  });

  String code;
  String message;
  List<ModeDataField> modeDataFields;

  factory UpiPaymentMethodDetailsModel.fromJson(Map<String, dynamic> json) => UpiPaymentMethodDetailsModel(
    code: json["code"],
    message: json["message"],
    modeDataFields: List<ModeDataField>.from(json["mode_data_fields"].map((x) => ModeDataField.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "mode_data_fields": List<dynamic>.from(modeDataFields.map((x) => x.toJson())),
  };
}

class ModeDataField {
  ModeDataField({
    required this.id,
    required this.countrywiseUpiCompanyId,
    required this.fieldName,
    required this.fieldValue,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int countrywiseUpiCompanyId;
  String fieldName;
  String fieldValue;
  dynamic createdAt;
  dynamic updatedAt;

  factory ModeDataField.fromJson(Map<String, dynamic> json) => ModeDataField(
    id: json["id"],
    countrywiseUpiCompanyId: json["countrywise_upi_company_id"],
    fieldName: json["field_name"],
    fieldValue: json["field_value"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countrywise_upi_company_id": countrywiseUpiCompanyId,
    "field_name": fieldName,
    "field_value": fieldValue,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
