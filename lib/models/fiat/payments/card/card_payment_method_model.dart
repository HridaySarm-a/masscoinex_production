// To parse this JSON data, do
//
//     final cardPaymentMethodModel = cardPaymentMethodModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CardPaymentMethodModel cardPaymentMethodModelFromJson(String str) => CardPaymentMethodModel.fromJson(json.decode(str));

String cardPaymentMethodModelToJson(CardPaymentMethodModel data) => json.encode(data.toJson());

class CardPaymentMethodModel {
  CardPaymentMethodModel({
    required this.code,
    required this.message,
    required this.paymentMethods,
  });

  String code;
  String message;
  List<PaymentMethod> paymentMethods;

  factory CardPaymentMethodModel.fromJson(Map<String, dynamic> json) => CardPaymentMethodModel(
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
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String status;
  dynamic createdAt;
  dynamic updatedAt;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
