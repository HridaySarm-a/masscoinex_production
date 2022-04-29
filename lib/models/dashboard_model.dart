// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    required this.code,
    required this.message,
    required this.cryptoData,
    required this.notifications,
    required this.fees,
    required this.wallet,
    required this.menu,
    required this.isMenuShow,
  });

  String code;
  String message;
  List<CryptoDatum> cryptoData;
  List<Notification> notifications;
  List<Fee> fees;
  Wallet wallet;
  Menu menu;
  int isMenuShow;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        code: json["code"],
        message: json["message"],
        cryptoData: List<CryptoDatum>.from(
            json["crypto_data"].map((x) => CryptoDatum.fromJson(x))),
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        wallet: Wallet.fromJson(json["wallet"]),
        fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
        menu: Menu.fromJson(json["menu"]),
        isMenuShow: json["is_menu_show"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "crypto_data": List<dynamic>.from(cryptoData.map((x) => x.toJson())),
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "wallet": wallet.toJson(),
        "fees": List<dynamic>.from(fees.map((x) => x.toJson())),
        "menu": menu.toJson(),
        "is_menu_show": isMenuShow,
      };
}

class CryptoDatum {
  String coinName;
  String coinSymbol;
  String coinImage;
  String currencyCode;
  dynamic cryptoWallet;
  String buyPrice;
  String sellPrice;

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

class Fee {
  Fee({
    required this.id,
    required this.coinCode,
    required this.coinName,
    required this.coinBuyRate,
    required this.coinBuyTransactionRate,
    required this.coinSellRate,
    required this.coinSellTransactionRate,
    required this.coinSendRate,
    required this.coinSendTransactionRate,
    required this.coinReceiveRate,
    required this.coinReceiveTransactionRate,
    required this.coinSwapRate,
    required this.coinSwapTransactionRate,
    required this.cryptoToCryptoBuyRate,
    required this.cryptoToCryptoBuyTranscationRate,
    required this.coinDepositTransactionRate,
    required this.coinWithdrawTransactionRate,
    required this.coinStatus,
    required this.addToCrypto,
    required this.coinInitialRate,
    required this.minCoinPurchase,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic coinCode;
  dynamic coinName;
  dynamic coinBuyRate;
  dynamic coinBuyTransactionRate;
  dynamic coinSellRate;
  dynamic coinSellTransactionRate;
  dynamic coinSendRate;
  dynamic coinSendTransactionRate;
  dynamic coinReceiveRate;
  dynamic coinReceiveTransactionRate;
  dynamic coinSwapRate;
  dynamic coinSwapTransactionRate;
  dynamic cryptoToCryptoBuyRate;
  dynamic cryptoToCryptoBuyTranscationRate;
  dynamic coinDepositTransactionRate;
  dynamic coinWithdrawTransactionRate;
  dynamic coinStatus;
  dynamic addToCrypto;
  dynamic coinInitialRate;
  dynamic minCoinPurchase;
  DateTime createdAt;
  DateTime updatedAt;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    id: json["id"],
    coinCode: json["coin_code"],
    coinName: json["coin_name"],
    coinBuyRate: json["coin_buy_rate"],
    coinBuyTransactionRate: json["coin_buy_transaction_rate"],
    coinSellRate: json["coin_sell_rate"],
    coinSellTransactionRate: json["coin_sell_transaction_rate"],
    coinSendRate: json["coin_send_rate"],
    coinSendTransactionRate: json["coin_send_transaction_rate"],
    coinReceiveRate: json["coin_receive_rate"],
    coinReceiveTransactionRate: json["coin_receive_transaction_rate"],
    coinSwapRate: json["coin_swap_rate"],
    coinSwapTransactionRate: json["coin_swap_transaction_rate"],
    cryptoToCryptoBuyRate: json["crypto_to_crypto_buy_rate"] == null ? null : json["crypto_to_crypto_buy_rate"],
    cryptoToCryptoBuyTranscationRate: json["crypto_to_crypto_buy_transcation_rate"] == null ? null : json["crypto_to_crypto_buy_transcation_rate"],
    coinDepositTransactionRate: json["coin_deposit_transaction_rate"],
    coinWithdrawTransactionRate: json["coin_withdraw_transaction_rate"],
    coinStatus: json["coin_status"],
    addToCrypto: json["add_to_crypto"] == null ? null : json["add_to_crypto"],
    coinInitialRate: json["coin_initial_rate"] == null ? null : json["coin_initial_rate"],
    minCoinPurchase: json["min_coin_purchase"] == null ? null : json["min_coin_purchase"].toDouble(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coin_code": coinCode,
    "coin_name": coinName,
    "coin_buy_rate": coinBuyRate,
    "coin_buy_transaction_rate": coinBuyTransactionRate,
    "coin_sell_rate": coinSellRate,
    "coin_sell_transaction_rate": coinSellTransactionRate,
    "coin_send_rate": coinSendRate,
    "coin_send_transaction_rate": coinSendTransactionRate,
    "coin_receive_rate": coinReceiveRate,
    "coin_receive_transaction_rate": coinReceiveTransactionRate,
    "coin_swap_rate": coinSwapRate,
    "coin_swap_transaction_rate": coinSwapTransactionRate,
    "crypto_to_crypto_buy_rate": cryptoToCryptoBuyRate == null ? null : cryptoToCryptoBuyRate,
    "crypto_to_crypto_buy_transcation_rate": cryptoToCryptoBuyTranscationRate == null ? null : cryptoToCryptoBuyTranscationRate,
    "coin_deposit_transaction_rate": coinDepositTransactionRate,
    "coin_withdraw_transaction_rate": coinWithdrawTransactionRate,
    "coin_status": coinStatus,
    "add_to_crypto": addToCrypto == null ? null : addToCrypto,
    "coin_initial_rate": coinInitialRate == null ? null : coinInitialRate,
    "min_coin_purchase": minCoinPurchase == null ? null : minCoinPurchase,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Menu {
  Menu({
    required this.bank,
    required this.card,
    required this.fees,
    required this.history,
    required this.notifications,
    required this.securityCenter,
    required this.supportCenter,
    required this.aboutApp,
  });

  int bank;
  int card;
  int fees;
  int history;
  int notifications;
  int securityCenter;
  int supportCenter;
  int aboutApp;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    bank: json["bank"],
    card: json["card"],
    fees: json["fees"],
    history: json["history"],
    notifications: json["notifications"],
    securityCenter: json["security_center"],
    supportCenter: json["support_center"],
    aboutApp: json["about_app"],
  );

  Map<String, dynamic> toJson() => {
    "bank": bank,
    "card": card,
    "fees": fees,
    "history": history,
    "notifications": notifications,
    "security_center": securityCenter,
    "support_center": supportCenter,
    "about_app": aboutApp,
  };
}

class Notification {
  String notificationMsg;

  Notification({
    required this.notificationMsg,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        notificationMsg: json["notification_msg"],
      );

  Map<String, dynamic> toJson() => {
        "notification_msg": notificationMsg,
      };
}

class Wallet {
  dynamic userId;
  dynamic amount;
  dynamic currency;

  Wallet({
    required this.userId,
    required this.amount,
    required this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        userId: json["user_id"],
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "amount": amount,
        "currency": currency,
      };
}
