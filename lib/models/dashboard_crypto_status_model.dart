class DashBoardCryptoStatusModel {
  String cryptoAsset;
  String cryptoName;
  String cryptoNameSmall;
  String cryptoPrice;
  String cryptoPriceDollarBuy;
  String cryptoPriceDollarSell;
  int priceColor;
  DashBoardCryptoStatusModel({
    required this.cryptoAsset,
    required this.cryptoName,
    required this.cryptoNameSmall,
    required this.cryptoPrice,
    required this.cryptoPriceDollarBuy,
    required this.cryptoPriceDollarSell,
    required this.priceColor,
  });
}
