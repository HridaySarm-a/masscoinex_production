import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masscoinex/controllers/add_account_controller.dart';
import 'package:masscoinex/controllers/add_account_controller_new_logic_force.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_card_new_logic_force/card_fields_screen.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_card_new_logic_force/card_picture_screen.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_card_new_logic_force/card_video_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddCardScreenNewLogicForce extends StatelessWidget {
  final _addAccountController = Get.put(AddAccountControllerNewLogicForce());

  AddCardScreenNewLogicForce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardScreens = [
      CardFieldsScreenNewLogicForce(
        addAccountController: _addAccountController,
      ),
      CardPictureScreenNewLogicForce(
        addAccountController: _addAccountController,
      ),
      CardVideoScreenNewLogicForce(
        addAccountController: _addAccountController,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Card Account"),
        backgroundColor: GlobalVals.appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Obx(
          () => IndexedStack(
            children: cardScreens,
            index: _addAccountController.cardScreenIndex.value,
          ),
        ),
      ),
    );
  }
}
