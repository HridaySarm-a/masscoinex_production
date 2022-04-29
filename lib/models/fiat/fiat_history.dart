// To parse this JSON data, do
//
//     final fiatHistoryModel = fiatHistoryModelFromJson(jsonString);
import 'dart:convert';

FiatHistoryModel fiatHistoryModelFromJson(String str) => FiatHistoryModel.fromJson(json.decode(str));

String fiatHistoryModelToJson(FiatHistoryModel data) => json.encode(data.toJson());

class FiatHistoryModel {
  FiatHistoryModel({
    required this.code,
    required this.message,
    required this.transactions,
  });

  String code;
  String message;
  List<Transaction> transactions;

  factory FiatHistoryModel.fromJson(Map<String, dynamic> json) => FiatHistoryModel(
    code: json["code"],
    message: json["message"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    required this.transactionNo,
    required this.amount,
    required this.transactionFee,
    required this.currency,
    required this.payAmount,
    required this.mode,
    required this.paymentStatus,
    required this.createdAt,
  });

  dynamic transactionNo;
  dynamic amount;
  dynamic transactionFee;
  dynamic currency;
  dynamic payAmount;
  dynamic mode;
  dynamic paymentStatus;
  DateTime createdAt;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionNo: json["transaction_no"] == null ? null : json["transaction_no"],
    amount: json["amount"],
    transactionFee: json["transaction_fee"],
    currency: json["currency"],
    payAmount: json["pay_amount"] == null ? null : json["pay_amount"],
    mode: json["mode"],
    paymentStatus: json["payment_status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "transaction_no": transactionNo == null ? null : transactionNo,
    "amount": amount,
    "transaction_fee": transactionFee,
    "currency": currency,
    "pay_amount": payAmount == null ? null : payAmount,
    "mode": mode,
    "payment_status": paymentStatus,
    "created_at": createdAt.toIso8601String(),
  };
}
