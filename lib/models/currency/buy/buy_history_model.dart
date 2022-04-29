// To parse this JSON data, do
//
//     final buyHistoryModel = buyHistoryModelFromJson(jsonString);

import 'dart:convert';

BuyHistoryModel buyHistoryModelFromJson(String str) =>
    BuyHistoryModel.fromJson(json.decode(str));

String buyHistoryModelToJson(BuyHistoryModel data) =>
    json.encode(data.toJson());

class BuyHistoryModel {
  String code;
  String message;
  List<CryptoDatum> cryptoData;
  List<Transaction> transactions;

  BuyHistoryModel({
    required this.code,
    required this.message,
    required this.cryptoData,
    required this.transactions,
  });

  factory BuyHistoryModel.fromJson(Map<String, dynamic> json) =>
      BuyHistoryModel(
        code: json["code"],
        message: json["message"],
        cryptoData: List<CryptoDatum>.from(
            json["crypto_data"].map((x) => CryptoDatum.fromJson(x))),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "crypto_data": List<dynamic>.from(cryptoData.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class CryptoDatum {
  dynamic coinName;
  dynamic coinSymbol;
  dynamic coinImage;
  dynamic currencyCode;
  dynamic cryptoWallet;
  dynamic buyPrice;
  dynamic sellPrice;

  CryptoDatum({
    required this.coinName,
    required this.coinSymbol,
    required this.coinImage,
    required this.currencyCode,
    required this.cryptoWallet,
    required this.buyPrice,
    required this.sellPrice,
  });

  factory CryptoDatum.fromJson(Map<String, dynamic> json) => CryptoDatum(
        coinName: json["coin_name"],
        coinSymbol: json["coin_symbol"],
        coinImage: json["coin_image"],
        currencyCode: json["currency_code"],
        cryptoWallet: json["crypto_wallet"],
        buyPrice: json["buy_price"],
        sellPrice: json["sell_price"],
      );

  Map<String, dynamic> toJson() => {
        "coin_name": coinName,
        "coin_symbol": coinSymbol,
        "coin_image": coinImage,
        "currency_code": currencyCode,
        "crypto_wallet": cryptoWallet,
        "buy_price": buyPrice,
        "sell_price": sellPrice,
      };
}

class Transaction {
  Transaction({
    required this.updatedAt,
    required this.transactionStatus,
    required this.cryptoAmount,
    required this.cryptoValue,
    required this.transactionFeeRate,
    required this.transactionFee,
    required this.currency,
    required this.transactionNo,
  });

  dynamic updatedAt;
  dynamic transactionStatus;
  dynamic cryptoAmount;
  dynamic cryptoValue;
  dynamic transactionFeeRate;
  dynamic transactionFee;
  dynamic currency;
  dynamic transactionNo;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        updatedAt: DateTime.parse(json["updated_at"]),
        transactionStatus: json["transaction_status"],
        cryptoAmount:
            json["crypto_amount"] == null ? null : json["crypto_amount"],
        cryptoValue: json["crypto_value"] == null ? null : json["crypto_value"],
        transactionFeeRate: json["transaction_fee_rate"] == null
            ? null
            : json["transaction_fee_rate"],
        transactionFee:
            json["transaction_fee"] == null ? null : json["transaction_fee"],
        currency: json["currency"] == null ? null : json["currency"],
        transactionNo:
            json["transaction_no"] == null ? null : json["transaction_no"],
      );

  Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toIso8601String(),
        "transaction_status": transactionStatus,
        "crypto_amount": cryptoAmount == null ? null : cryptoAmount,
        "crypto_value": cryptoValue == null ? null : cryptoValue,
        "transaction_fee_rate":
            transactionFeeRate == null ? null : transactionFeeRate,
        "transaction_fee": transactionFee == null ? null : transactionFee,
        "currency": currency == null ? null : currency,
        "transaction_no": transactionNo == null ? null : transactionNo,
      };
}
