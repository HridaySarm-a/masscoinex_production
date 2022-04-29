import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class MobileVerificationController extends GetxController {
  var countdownController = CountDownController();
  var isCountdownEnded = false.obs;
}
