// To parse this JSON data, do
//
//     final upiDepositConfirmationModel = upiDepositConfirmationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpiDepositConfirmationModel upiDepositConfirmationModelFromJson(String str) =>
    UpiDepositConfirmationModel.fromJson(json.decode(str));

String upiDepositConfirmationModelToJson(UpiDepositConfirmationModel data) =>
    json.encode(data.toJson());

class UpiDepositConfirmationModel {
  UpiDepositConfirmationModel({
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

  String code;
  String message;
  String gatewayMethod;
  String paymentMethodId;
  String paymentMethodName;
  List<UserDatum> userData;
  dynamic amount;
  dynamic depositFee;
  dynamic depositAmount;
  String transactionNo;
  String currency;

  factory UpiDepositConfirmationModel.fromJson(Map<String, dynamic> json) =>
      UpiDepositConfirmationModel(
        code: json["code"],
        message: json["message"],
        gatewayMethod: json["gateway_method"],
        paymentMethodId: json["payment_method_id"],
        paymentMethodName: json["payment_method_name"],
        userData: List<UserDatum>.from(
            json["user_data"].map((x) => UserDatum.fromJson(x))),
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
    required this.upiId,
    required this.upiCodeName,
    required this.upiCode,
  });

  int id;
  dynamic upiId;
  dynamic upiCodeName;
  dynamic upiCode;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"],
        upiId: json["upi_id"] == null ? null : json["upi_id"],
        upiCodeName: json["upi_code_name"],
        upiCode: json["upi_code"] == null ? null : json["upi_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "upi_id": upiId == null ? null : upiId,
        "upi_code_name": upiCodeName,
        "upi_code": upiCode == null ? null : upiCode,
      };
}
