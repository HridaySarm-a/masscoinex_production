import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/dashboard_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/fiat_main/fiat_wallet_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/fiat_main/fiat_wallet_screen_copy.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/profile_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/profile_screen_copy.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/swap_screen.dart';

class MainController extends GetxController {
  var bottomIndex = 0.obs;
  static const bottomIcons = [
    Icons.dashboard_outlined,
    FontAwesomeIcons.random,
    Icons.account_balance_wallet_outlined,
    FontAwesomeIcons.user,
  ];
  var bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        activeIcon: Icon(Icons.dashboard),
        label: "Dashboard"),
    BottomNavigationBarItem(
        icon: Icon(Icons.shuffle_outlined),
        activeIcon: Icon(Icons.shuffle),
        label: "Swap"),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_outlined),
        activeIcon: Icon(Icons.account_balance_wallet),
        label: "Fiat Wallet"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: "Profile"),
  ];
  var screens = [
    DashboardScreen(),
    SwapScreen(),
    FiatWalletScreenCopy(),
    ProfileScreenCopy(),
  ];
}
