// To parse this JSON data, do
//
//     final bankPaymentMethodModel = bankPaymentMethodModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BankPaymentMethodModel bankPaymentMethodModelFromJson(String str) => BankPaymentMethodModel.fromJson(json.decode(str));

String bankPaymentMethodModelToJson(BankPaymentMethodModel data) => json.encode(data.toJson());

class BankPaymentMethodModel {
  BankPaymentMethodModel({
    required this.code,
    required this.message,
    required this.paymentMethods,
  });

  String code;
  String message;
  List<PaymentMethod> paymentMethods;

  factory BankPaymentMethodModel.fromJson(Map<String, dynamic> json) => BankPaymentMethodModel(
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
    required this.bankName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String bankName;
  String status;
  dynamic createdAt;
  dynamic updatedAt;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    bankName: json["bank_name"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
