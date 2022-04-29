// To parse this JSON data, do
//
//     final getWithdrawModel = getWithdrawModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetWithdrawModel getWithdrawModelFromJson(String str) => GetWithdrawModel.fromJson(json.decode(str));

String getWithdrawModelToJson(GetWithdrawModel data) => json.encode(data.toJson());

class GetWithdrawModel {
  GetWithdrawModel({
    required this.code,
    required this.message,
    required this.transcations,
  });

  String code;
  String message;
  Transcations transcations;

  factory GetWithdrawModel.fromJson(Map<String, dynamic> json) => GetWithdrawModel(
    code: json["code"],
    message: json["message"],
    transcations: Transcations.fromJson(json["transcations"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "transcations": transcations.toJson(),
  };
}

class Transcations {
  Transcations({
    required this.message,
    required this.amount,
    required this.transcationFee,
    required this.fiatWithdrawTransactionRate,
    required this.payAmount,
  });

  int message;
  String amount;
  String transcationFee;
  String fiatWithdrawTransactionRate;
  String payAmount;

  factory Transcations.fromJson(Map<String, dynamic> json) => Transcations(
    message: json["message"],
    amount: json["amount"],
    transcationFee: json["transcation_fee"],
    fiatWithdrawTransactionRate: json["fiat_withdraw_transaction_rate"],
    payAmount: json["pay_amount"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "amount": amount,
    "transcation_fee": transcationFee,
    "fiat_withdraw_transaction_rate": fiatWithdrawTransactionRate,
    "pay_amount": payAmount,
  };
}
