// To parse this JSON data, do
//
//     final bankWithdrawConfirmationModel = bankWithdrawConfirmationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BankWithdrawConfirmationModel bankWithdrawConfirmationModelFromJson(String str) => BankWithdrawConfirmationModel.fromJson(json.decode(str));

String bankWithdrawConfirmationModelToJson(BankWithdrawConfirmationModel data) => json.encode(data.toJson());

class BankWithdrawConfirmationModel {
  BankWithdrawConfirmationModel({
    required this.code,
    required this.message,
    required this.paymentMode,
    required this.amount,
    required this.currency,
    required this.userBanks,
  });

  String code;
  String message;
  String paymentMode;
  String amount;
  String currency;
  List<UserBank> userBanks;

  factory BankWithdrawConfirmationModel.fromJson(Map<String, dynamic> json) => BankWithdrawConfirmationModel(
    code: json["code"],
    message: json["message"],
    paymentMode: json["payment_mode"],
    amount: json["amount"],
    currency: json["currency"],
    userBanks: List<UserBank>.from(json["user_banks"].map((x) => UserBank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "payment_mode": paymentMode,
    "amount": amount,
    "currency": currency,
    "user_banks": List<dynamic>.from(userBanks.map((x) => x.toJson())),
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

  String id;
  String userId;
  dynamic bankName;
  String bankAddress;
  String bankState;
  String bankCity;
  String bankZip;
  String bankCode;
  String bankTelephone;
  String fullName;
  String accountNo;
  String bankStatus;
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
