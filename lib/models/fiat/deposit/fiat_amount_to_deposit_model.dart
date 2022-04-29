// To parse this JSON data, do
//
//     final fiatAmountToDepositModel = fiatAmountToDepositModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FiatAmountToDepositModel fiatAmountToDepositModelFromJson(String str) => FiatAmountToDepositModel.fromJson(json.decode(str));

String fiatAmountToDepositModelToJson(FiatAmountToDepositModel data) => json.encode(data.toJson());

class FiatAmountToDepositModel {
  FiatAmountToDepositModel({
    required this.code,
    required this.message,
    required this.transcations,
  });

  String code;
  String message;
  Transcations transcations;

  factory FiatAmountToDepositModel.fromJson(Map<String, dynamic> json) => FiatAmountToDepositModel(
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
    required this.transcationFee,
    required this.fiatDepositTransactionRate,
    required this.payAmount,
  });

  String transcationFee;
  String fiatDepositTransactionRate;
  String payAmount;

  factory Transcations.fromJson(Map<String, dynamic> json) => Transcations(
    transcationFee: json["transcation_fee"],
    fiatDepositTransactionRate: json["fiat_deposit_transaction_rate"],
    payAmount: json["pay_amount"],
  );

  Map<String, dynamic> toJson() => {
    "transcation_fee": transcationFee,
    "fiat_deposit_transaction_rate": fiatDepositTransactionRate,
    "pay_amount": payAmount,
  };
}
