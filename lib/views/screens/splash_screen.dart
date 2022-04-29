import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

/* class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Image.asset(
        "assets/splash.png",
      ),
      splashIconSize: 25.h,
      nextScreen: MainScreen(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: GlobalVals.backgroundColor,
    );
  }
} */

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool isLoggedIn = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  var _logger = Logger();

  @override
  void initState() {
    /* final box = GetStorage(); */
    //isLoggedIn = box.read("loggedIn") ?? false;
    getLoginStatus();
    super.initState();
  }

  void getLoginStatus() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    isLoggedIn = _box.get(GlobalVals.isLoggedIn) ?? false;
    _logger.d(isLoggedIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(
          isLoggedIn == true ? Routes.mainScreenCopy : Routes.mainScreen);
    });
    getProfileInfo();
    return Scaffold(
      backgroundColor: GlobalVals.backgroundColor,
      body: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: Center(
          child: Image.asset(
            "assets/splash.png",
            color: Colors.white,
            height: 55.h,
            width: 75.w,
          ),
        ),
      ),
    );
  }

  getProfileInfo() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    if (!isLoggedIn) {
      /* Future.delayed(Duration(seconds: 3), () {
        Get.toNamed(Routes.mainScreen);
      }); */
    } else {
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
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.profileInfo),
        headers: _header,
      );
      _logger.d(_response.body);
      if (_response.statusCode == 200) {
        _box.put(GlobalVals.profileInfo, _response.body);
        //Get.offAllNamed(Routes.mainScreenCopy);
        //responseResult.value = _response.body;
        // var _result = DashboardModel.fromJson(json.decode(_response.body));
        //resultLength.value = _result.cryptoData.length;
        /* 
      _logger.d(_token); */
      } else {
        //Get.offAllNamed(Routes.mainScreen);
        GlobalVals.errorToast("Server Error");
      }
    }
  }
}
