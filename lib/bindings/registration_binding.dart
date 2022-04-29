import 'package:get/get.dart';
import 'package:masscoinex/controllers/kyc/document_controller.dart';
import 'package:masscoinex/controllers/mobile_verification_controller.dart';
import 'package:masscoinex/controllers/registration_controller.dart';
import 'package:masscoinex/controllers/registration_details_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationDetailsController());
    Get.lazyPut(() => RegistrationController());
    Get.lazyPut(() => MobileVerificationController());
    Get.lazyPut(() => RegDocumentController());
  }
}