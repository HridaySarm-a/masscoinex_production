// To parse this JSON data, do
//
//     final bankDepositConfirmationModel = bankDepositConfirmationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BankDepositConfirmationModel bankDepositConfirmationModelFromJson(String str) => BankDepositConfirmationModel.fromJson(json.decode(str));

String bankDepositConfirmationModelToJson(BankDepositConfirmationModel data) => json.encode(data.toJson());

class BankDepositConfirmationModel {
  BankDepositConfirmationModel({
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
  List<UserBank> userData;
  String amount;
  int depositFee;
  String depositAmount;
  String transactionNo;
  String currency;

  factory BankDepositConfirmationModel.fromJson(Map<String, dynamic> json) => BankDepositConfirmationModel(
    code: json["code"],
    message: json["message"],
    gatewayMethod: json["gateway_method"],
    paymentMethodId: json["payment_method_id"],
    paymentMethodName: json["payment_method_name"],
    userData: List<UserBank>.from(json["user_data"].map((x) => UserBank.fromJson(x))),
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

class UserBank {
  UserBank({
    required this.id,
    required this.userId,
    required this.bankName,
    required this.bankAddress,
    required this.bankState,
    required this.bankCity,
    required this.bankZip,
    required this.bankCode,
    required this.bankTelephone,
    required this.fullName,
    required this.accountNo,
    required this.bankStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic bankName;
  dynamic bankAddress;
  dynamic bankState;
  dynamic bankCity;
  dynamic bankZip;
  dynamic bankCode;
  dynamic bankTelephone;
  dynamic fullName;
  dynamic accountNo;
  dynamic bankStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserBank.fromJson(Map<String, dynamic> json) => UserBank(
    id: json["id"],
    userId: json["user_id"],
    bankName: json["bank_name"],
    bankAddress: json["bank_address"],
    bankState: json["bank_state"],
    bankCity: json["bank_city"],
    bankZip: json["bank_zip"],
    bankCode: json["bank_code"],
    bankTelephone: json["bank_telephone"],
    fullName: json["full_name"],
    accountNo: json["account_no"],
    bankStatus: json["bank_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bank_name": bankName,
    "bank_address": bankAddress,
    "bank_state": bankState,
    "bank_city": bankCity,
    "bank_zip": bankZip,
    "bank_code": bankCode,
    "bank_telephone": bankTelephone,
    "full_name": fullName,
    "account_no": accountNo,
    "bank_status": bankStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
