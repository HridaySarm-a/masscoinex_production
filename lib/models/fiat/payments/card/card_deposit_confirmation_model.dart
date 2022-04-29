// To parse this JSON data, do
//
//     final cardDepositConfirmationModel = cardDepositConfirmationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CardDepositConfirmationModel cardDepositConfirmationModelFromJson(String str) => CardDepositConfirmationModel.fromJson(json.decode(str));

String cardDepositConfirmationModelToJson(CardDepositConfirmationModel data) => json.encode(data.toJson());

class CardDepositConfirmationModel {
  CardDepositConfirmationModel({
    required this.code,
    required this.message,
    required this.gatewayMethod,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.userData,
    required this.amount,
    required this.depositFee,
    required this.depositAmount,
    required this.transactionNo,
    required this.currency,
  });

  dynamic code;
  dynamic message;
  dynamic gatewayMethod;
  dynamic paymentMethodId;
  dynamic paymentMethodName;
  List<UserDatum> userData;
  dynamic amount;
  dynamic depositFee;
  dynamic depositAmount;
  dynamic transactionNo;
  dynamic currency;

  factory CardDepositConfirmationModel.fromJson(Map<String, dynamic> json) => CardDepositConfirmationModel(
    code: json["code"],
    message: json["message"],
    gatewayMethod: json["gateway_method"],
    paymentMethodId: json["payment_method_id"],
    paymentMethodName: json["payment_method_name"],
    userData: List<UserDatum>.from(json["user_data"].map((x) => UserDatum.fromJson(x))),
    amount: json["amount"],
    depositFee: json["deposit_fee"],
    depositAmount: json["deposit_amount"],
    transactionNo: json["transaction_no"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "gateway_method": gatewayMethod,
    "payment_method_id": paymentMethodId,
    "payment_method_name": paymentMethodName,
    "user_data": List<dynamic>.from(userData.map((x) => x.toJson())),
    "amount": amount,
    "deposit_fee": depositFee,
    "deposit_amount": depositAmount,
    "transaction_no": transactionNo,
    "currency": currency,
  };
}

class UserDatum {
  UserDatum({
    required this.id,
    required this.userId,
    required this.nameOnCard,
    required this.billingAddress,
    required this.telephone,
    required this.country,
    required this.cardNumber,
    required this.cardType,
    required this.cardExpiry,
    required this.cardCvc,
    required this.state,
    required this.city,
    required this.zip,
    required this.videoName,
    required this.cardStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic nameOnCard;
  dynamic billingAddress;
  dynamic telephone;
  dynamic country;
  dynamic cardNumber;
  dynamic cardType;
  dynamic cardExpiry;
  dynamic cardCvc;
  dynamic state;
  dynamic city;
  dynamic zip;
  dynamic videoName;
  dynamic cardStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["id"],
    userId: json["user_id"],
    nameOnCard: json["name_on_card"],
    billingAddress: json["billing_address"],
    telephone: json["telephone"],
    country: json["country"],
    cardNumber: json["card_number"],
    cardType: json["card_type"],
    cardExpiry: json["card_expiry"],
    cardCvc: json["card_cvc"],
    state: json["state"] == null ? null : json["state"],
    city: json["city"] == null ? null : json["city"],
    zip: json["zip"] == null ? null : json["zip"],
    videoName: json["video_name"] == null ? null : json["video_name"],
    cardStatus: json["card_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name_on_card": nameOnCard,
    "billing_address": billingAddress,
    "telephone": telephone,
    "country": country,
    "card_number": cardNumber,
    "card_type": cardType,
    "card_expiry": cardExpiry,
    "card_cvc": cardCvc,
    "state": state == null ? null : state,
    "city": city == null ? null : city,
    "zip": zip == null ? null : zip,
    "video_name": videoName == null ? null : videoName,
    "card_status": cardStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

