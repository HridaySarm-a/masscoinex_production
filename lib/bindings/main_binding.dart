import 'package:get/get.dart';
import 'package:masscoinex/controllers/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
