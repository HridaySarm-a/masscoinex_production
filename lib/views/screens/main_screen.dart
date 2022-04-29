import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/main/main_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainScreen extends StatelessWidget {
  final MainController _mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo_white.png",
                height: 4.h,
                width: 15.w,
              ),
              SizedBox(
                width: 15.w,
              ),
            ],
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
        ),
        drawer: _drawer(),
        body: IndexedStack(
          children: _mainController.screens,
          index: _mainController.bottomIndex.value,
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          },
          currentIndex: _mainController.bottomIndex.value,
        ),
      ),
    );
  }

  Widget _drawer() => Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 1.h),
                          child: CircleAvatar(
                            backgroundColor: GlobalVals.appbarColor,
                            radius: 3.h,
                            child: Image.asset(
                              "assets/logo_white.png",
                              height: 4.h,
                              width: 8.w,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Welcome to Masscoinex\n",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: "Please Login to continue",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _tiles(
              Icons.ballot_outlined,
              "Verify Identity (KYC)",
              "Upload documents to complete the KYC process",
              () {},
            ),
            _tiles(Icons.account_balance_outlined, "Bank & Card",
                "View & edit your bank & card details", () {}),
            _tiles(Icons.history_outlined, "Transaction History",
                "View your crypto and fiat transactions", () {}),
            _tiles(
                Icons.local_offer_outlined,
                "Fees",
                "See all fees including membership, withdrawal, deposit",
                () {}),
            _tiles(Icons.notifications_outlined, "Notifications",
                "Controll all app notifications", () {}),
            _tiles(Icons.security_outlined, "Security Center",
                "Set security features like change pin, password and more", () {
              Get.toNamed(Routes.security);
              print("I am here");
            }),
            _tiles(Icons.headset_mic_outlined, "Support Center",
                "Create a ticket and we will contact you", () {
              Get.toNamed(Routes.support);
            }),
            ListTile(
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
            ),
          ],
        ),
      );
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
}
