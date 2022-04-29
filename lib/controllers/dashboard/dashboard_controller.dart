import 'package:get/get.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/dashboard_crypto_status_model.dart';

class DashBoardController extends GetxController {
  var isDashboardLoading = false.obs;
  var responseResult = "".obs;
  var resultLength = 0.obs;
  var _logger = Logger();
  getAllDashboard() async {
    isDashboardLoading.value = true;
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.dashboardData),
    );
    if (_response.statusCode == 200) {
      isDashboardLoading.value = false;
      _box.put(GlobalVals.dashBoardData, _response.body);
      responseResult.value = _response.body;
      _logger.d(_response.body);
      var _result = DashboardModel.fromJson(json.decode(_response.body));
      resultLength.value = _result.cryptoData.length;
      /* _logger.d(_response.body);
      _logger.d(_token); */
    } else {
      GlobalVals.errorToast("Server Error");
    }
  }

  @override
  void onInit() {
    getAllDashboard();
    super.onInit();
  }

  var dashBoardCryptoStatusModels = [
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/bitcoin.png",
      cryptoName: "Bitcoin",
      cryptoNameSmall: "BTC",
      cryptoPrice: "0.02245",
      cryptoPriceDollarBuy: "\$12385",
      cryptoPriceDollarSell: "\$12585",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/ripple.png",
      cryptoName: "Ripple",
      cryptoNameSmall: "RPL",
      cryptoPrice: "1.234",
      cryptoPriceDollarBuy: "\$1385",
      cryptoPriceDollarSell: "\$1885",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/eos.png",
      cryptoName: "EOS",
      cryptoNameSmall: "EOS",
      cryptoPrice: "1.44",
      cryptoPriceDollarBuy: "\$2385",
      cryptoPriceDollarSell: "\$2485",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/ether.png",
      cryptoName: "Ether",
      cryptoNameSmall: "ETH",
      cryptoPrice: "11.3456",
      cryptoPriceDollarBuy: "\$1185",
      cryptoPriceDollarSell: "\$1585",
      priceColor: GlobalVals.raiseColor,
    ),
    DashBoardCryptoStatusModel(
      cryptoAsset: "assets/ion.png",
      cryptoName: "Ion",
      cryptoNameSmall: "ION",
      cryptoPrice: "0.000324",
      cryptoPriceDollarBuy: "\$6385",
      cryptoPriceDollarSell: "\$6885",
      priceColor: GlobalVals.downColor,
    ),
  ];
}
