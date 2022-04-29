class TransactionModelHistory {
  int id;
  String currencyLogoPath;
  String currencyName;
  String transactionID;
  String date;
  String currencyStat;
  String transactionType;
  String status;
  TransactionModelHistory({
    required this.id,
    required this.currencyLogoPath,
    required this.currencyName,
    required this.transactionID,
    required this.date,
    required this.currencyStat,
    required this.transactionType,
    required this.status,
  });
}
