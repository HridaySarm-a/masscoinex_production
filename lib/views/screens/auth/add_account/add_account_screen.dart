import 'package:flutter/material.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_card/card_fields_screen.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_card/card_picture_screen.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_card/card_video_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class AddAccountScreen extends StatelessWidget {
  final AddAccountController _addAccountController =
      Get.put(AddAccountController());
  @override
  Widget build(BuildContext context) {
    final _cardScreens = [
      CardFieldsScreen(
        addAccountController: _addAccountController,
      ),
      CardPictureScreen(
        addAccountController: _addAccountController,
      ),
      CardVideoScreen(
        addAccountController: _addAccountController,
      ),
    ];
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            _addAccountController.currentIndex.value = tabController.index;
            print("New tab index: ${tabController.index}");
          });
          return Scaffold(
            appBar: AppBar(
              title: Text("Add Account"),
              backgroundColor: GlobalVals.appbarColor,
              bottom: PreferredSize(
                preferredSize: _addAccountController.size,
                child: ColoredBox(
                  color: Colors.white,
                  child: _addAccountController.tabBar,
                ),
              ),
            ),
            body: _tabBars(_cardScreens),
          );
        },
      ),
    );
  }

  Widget _tabBars(var cardScreens) {
    return TabBarView(
      children: [
        Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Column(
              children: _addAccountController.addBank,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.h),
          child: Obx(
            () => IndexedStack(
              children: cardScreens,
              index: _addAccountController.cardScreenIndex.value,
            ),
          ),
        ),
      ],
    );
  }
}
