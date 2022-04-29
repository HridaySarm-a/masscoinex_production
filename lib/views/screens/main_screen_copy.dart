import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/controllers/main/main_controller_copy.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/about_model.dart';
import 'package:masscoinex/models/dashboard_model.dart';
import 'package:masscoinex/models/get_bank_model.dart';
import 'package:masscoinex/models/profile_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class MainScreenCopy extends StatelessWidget {
  final _mainController = Get.put(MainControllerCopy());
  final _scaffoldKey = GlobalKey<ScaffoldState>(); //new line
  final _box = Hive.box(GlobalVals.hiveBox);
  int _index = int.parse(
      Get.parameters["index"] != null ? Get.parameters["index"]! : "1234");
  final String _isComingFromCurrency =
      Get.parameters["isComingFromCurrency"] != null
          ? Get.parameters["isComingFromCurrency"]!
          : "no";
  final _curIndex = 0.obs;
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    _logger.d(_box.get(GlobalVals.profileInfo));
    ProfileModel? _userType =
        profileModelFromJson(_box.get(GlobalVals.profileInfo));
    // _getBanks();
    _getCurrency();
    /*Future.delayed(Duration(seconds: 1), () {
      if (_userType.result.kycStatus == "Pending") {
        if (_userType.result.userType == "kyc") {
          Get.toNamed(Routes.addBankNewLogicForce);
        } else if (_userType.result.userType == "non-kyc") {
          Get.toNamed(Routes.addBankNewLogicAnother);
        }
      } else {
        //Get.toNamed(Routes.currencySelectNewLogic);
      }
    });*/
    print("Indexxx $_index");
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    void openDrawer() {
      _scaffoldKey.currentState!.openDrawer();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Obx(() => _title()),
          leading: Obx(
            () => _mainController.shouldShowMenu.value != true
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      openDrawer();
                    },
                    icon: Icon(Icons.menu_rounded),
                    color: Colors.white,
                  ),
          ),
          bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 0.1.h,
            ),
            preferredSize: Size.fromHeight(
              0.1.h,
            ),
          ),
          backgroundColor: GlobalVals.appbarColor,
          actions: [
            Obx(
              () => _mainController.bottomIndex.value == 0
                  ? Padding(
                      padding: EdgeInsets.only(right: 1.h),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 2.h,
                            child: Icon(
                              Icons.person,
                              color: GlobalVals.appbarColor,
                            ),
                          ),
                          onTap: () {
                            _mainController.bottomIndex.value = 3;
                            _index = 3;
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
        drawer: Obx(() {
          return _mainController.shouldShowMenu.value == true
              ? _drawer(_userType)
              : SizedBox();
        }),
        body: Obx(
          () => IndexedStack(
            children: _mainController.screensCopy,
            index: currentIndex() != null
                ? currentIndex()!.value
                : _mainController.bottomIndex.value,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: GlobalVals.backgroundColor,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              color: GlobalVals.bottomNavSelectedColor,
            ),
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            items: _mainController.bottomNavItems,
            onTap: (index) {
              _mainController.bottomIndex.value = index;
              _index = index;
              print("IndexOfCurrency ");
              print("IndexOfBottom ${_mainController.bottomIndex.value}");
            },
            currentIndex: currentIndex() != null
                ? currentIndex()!.value
                : _mainController.bottomIndex.value,
          ),
        ),
      ),
    );
  }

  Widget _drawer(ProfileModel? _userType) {
    final _profileInfo =
        ProfileModel.fromJson(json.decode(_box.get(GlobalVals.profileInfo)));
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 1.h),
                          child: CircleAvatar(
                            backgroundColor: GlobalVals.appbarColor,
                            radius: 4.h,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 4.h,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${_profileInfo.result.fullName}\n",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: "${_profileInfo.result.email}\n",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: "${_profileInfo.result.phone}\n",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                ),
                              ),
                              WidgetSpan(
                                child: Obx(
                                  () => SizedBox(
                                    child: _mainController.dashBoardController
                                                .responseResult.value ==
                                            ""
                                        ? SizedBox()
                                        : _currencyText(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        _mainController.bottomIndex.value = 3;
                        _index = 3;
                      },
                      icon: Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                _userType!.result.kycStatus != "Approved"
                    ? _tiles(
                        Icons.ballot_outlined,
                        "Verify Identity (KYC)",
                        "Upload documents to complete the KYC process",
                        () {
                          Get.toNamed(Routes.verifyKyc);
                        },
                      )
                    : const SizedBox(),
                Obx(() {
                  return _mainController.bankAndCardTitle.value != ""
                      ? _tiles(
                          Icons.account_balance_outlined,
                          _mainController.bankAndCardTitle.value,
                          _mainController.bankAndCardSubtitle.value, () {
                          switch (_mainController.bankAndCardTitle.value) {
                            case "Bank":
                              Get.toNamed(Routes.addBankNewLogic);
                              break;
                            case "Card":
                              Get.toNamed(Routes.addCardNewLogic);
                              break;
                            default:
                              Get.toNamed(Routes.addCardOrBank);
                              break;
                          }
                        })
                      : const SizedBox();
                }),
                Obx(
                  () => _mainController.shouldShowCurrency.value == true
                      ? _userType.result.kycStatus != "Approved"
                          ? _tiles(Icons.paid_outlined, "Select Currency",
                              "Select your currency", () {
                              Get.toNamed(Routes.currencySelectNewLogic);
                            })
                          : SizedBox()
                      : SizedBox(),
                ),
                _tiles(Icons.history_outlined, "Transaction History",
                    "View your crypto and fiat transactions", () {
                  Get.toNamed(Routes.dashboardHistory);
                }),
                _tiles(Icons.payment, "Card List", "View your cards", () {
                  Get.toNamed(Routes.cardList);
                }),
                _tiles(
                    Icons.format_list_bulleted, "Bank List", "View your banks",
                    () {
                  Get.toNamed(Routes.bankList);
                }),
                /*_tiles(
                    Icons.local_offer_outlined,
                    "Fees",
                    "See all fees including membership, withdrawal, deposit",
                    () {}),*/
                _tiles(Icons.notifications_outlined, "Notifications",
                    "Control all app notifications", () {
                  Get.toNamed(Routes.notification);
                }),
                _tiles(Icons.security_outlined, "Security Center",
                    "Set security features like change pin, password and more",
                    () {
                  Get.toNamed(Routes.security);
                  print("I am here");
                }),
                _tiles(Icons.headset_mic_outlined, "Support Center",
                    "Create a ticket and we will contact you", () {
                  Get.toNamed(Routes.support);
                }),
                FutureBuilder<AboutModel?>(
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return ListTile(
                        dense: true,
                        leading: Image.asset(
                          "assets/logo_white.png",
                          width: 4.h,
                          color: Colors.grey,
                        ),
                        title: Text(
                          snapShot.data!.message,
                        ),
                        subtitle: Text(
                          snapShot.data!.result.version,
                        ),
                        onTap: () {
                          print("Heyee");
                        },
                      );
                    }
                    return ListTile(
                      dense: true,
                      leading: Image.asset(
                        "assets/logo_white.png",
                        width: 4.h,
                        color: Colors.grey,
                      ),
                      title: Text(
                        "About Masscoinex",
                      ),
                      subtitle: Text(
                        "1.0",
                      ),
                      onTap: () {
                        print("Heyee");
                      },
                    );
                  },
                  future: _getAbout(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.all(3.h),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5.h,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      /* var box = GetStorage();
                      box.write("loggedIn", false); */
                      /* final _box = await Hive.openBox(GlobalVals.hiveBox);
                      _box.put(GlobalVals.user, "");
                      _box.put(GlobalVals.isLoggedIn, false);
                      Get.offAllNamed(Routes.splashScreen);*/
                      _logout();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _currencyText() {
    var _result = DashboardModel.fromJson(
        json.decode(_mainController.dashBoardController.responseResult.value));
    var _currency = _result.wallet.currency ?? "";
    return Text(
      "Currency: $_currency",
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 14.sp,
      ),
    );
  }

  ListTile _tiles(IconData iconData, String title, String subTitle,
      VoidCallback voidCallback) {
    return ListTile(
      dense: true,
      leading: Icon(
        iconData,
        color: Colors.grey,
        size: 4.h,
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subTitle,
      ),
      onTap: voidCallback,
    );
  }

  RxInt? currentIndex() {
    print("IndexOfCurrency $_index");
    print("IndexOfBottom ${_mainController.bottomIndex.value}");
    print("IsComingFromCurrency $_isComingFromCurrency");
    if (_isComingFromCurrency == "no") {
      return null;
    } else {
      if (_index != 1234) {
        _curIndex.value = _index;
        return _index.obs;
      } else if (_curIndex.value != 0) {
        return 0.obs;
      } else {
        _curIndex.value = 0;
        return 0.obs;
      }
    }
  }

  Widget _title() {
    if (_mainController.bottomIndex.value == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo_white.png",
            height: 4.h,
            width: 15.w,
          ),
        ],
      );
    } else {
      switch (_mainController.bottomIndex.value) {
        case 1:
          return Text("Swap");
        case 2:
          return Text("Fiat Wallet");
        default:
          return Text("Profile");
      }
    }
  }

  _getCurrency() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.dashboard),
      headers: _header,
    );
    if (_response.statusCode == 200) {
      var _result = DashboardModel.fromJson(json.decode(_response.body));
      ProfileModel? _userType =
      profileModelFromJson(_box.get(GlobalVals.profileInfo));

      Future.delayed(Duration(seconds: 1), () {
        if (_userType.result.kycStatus == "Pending") {
          if(_result.wallet.currency != null){
            print('KYC is yet to be verified');
          }else{
            if(_userType.result.userType == "kyc"){
              Get.toNamed(Routes.addBankNewLogicForce);
            }else{
              Get.toNamed(Routes.addBankNewLogicAnother);
            }
          }
        } else {
          print("Everything  is perfect");
        }
      });
    }
  }

  _getBanks() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.getBanks),
      headers: _header,
    );
    if (_response.statusCode == 200) {
      var _result = GetBankModel.fromJson(json.decode(_response.body));
      var _listOfBanks = _result.result;
      ProfileModel? _userType =
          profileModelFromJson(_box.get(GlobalVals.profileInfo));


      Future.delayed(Duration(seconds: 1), () {
        if (_userType.result.kycStatus == "Pending") {
          if (_userType.result.userType == "kyc") {
            if (_listOfBanks.isEmpty) {
              Get.toNamed(Routes.addBankNewLogicForce);
            }
          } else if (_userType.result.userType == "non-kyc") {
            if (_listOfBanks.isEmpty) {
              Get.toNamed(Routes.addBankNewLogicAnother);
            }
          }
        } else {
          //Get.toNamed(Routes.currencySelectNewLogic);
        }
      });
    }
  }

  Future<AboutModel?> _getAbout() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.aboutUs),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      var _result = AboutModel.fromJson(json.decode(_response.body));
      return _result;
    } else {
      return null;
    }
  }

  _logout() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.post(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.logout),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      final _box = await Hive.openBox(GlobalVals.hiveBox);
      _box.put(GlobalVals.user, "");
      _box.put(GlobalVals.isLoggedIn, false);
      Get.offAllNamed(Routes.splashScreen);
    } else {
      GlobalVals.errorToast("Could not log out. Please try again later");
    }
  }
}
