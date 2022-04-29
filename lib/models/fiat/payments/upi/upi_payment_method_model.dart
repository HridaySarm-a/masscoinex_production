// To parse this JSON data, do
//
//     final upiPaymentMethodModel = upiPaymentMethodModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpiPaymentMethodModel upiPaymentMethodModelFromJson(String str) => UpiPaymentMethodModel.fromJson(json.decode(str));

String upiPaymentMethodModelToJson(UpiPaymentMethodModel data) => json.encode(data.toJson());

class UpiPaymentMethodModel {
  UpiPaymentMethodModel({
    required this.code,
    required this.message,
    required this.paymentMethods,
  });

  String code;
  String message;
  List<PaymentMethod> paymentMethods;

  factory UpiPaymentMethodModel.fromJson(Map<String, dynamic> json) => UpiPaymentMethodModel(
    code: json["code"],
    message: json["message"],
    paymentMethods: List<PaymentMethod>.from(json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "payment_methods": List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
  };
}

class PaymentMethod {
  PaymentMethod({
    required this.id,
    required this.upiName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String upiName;
  String status;
  dynamic createdAt;
  dynamic updatedAt;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    upiName: json["upi_name"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "upi_name": upiName,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
