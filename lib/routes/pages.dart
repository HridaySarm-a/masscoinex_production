import 'package:get/get.dart';
import 'package:masscoinex/bindings/registration_binding.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_account_screen.dart';
import 'package:masscoinex/views/screens/auth/add_account/add_account_complete_screen.dart';
import 'package:masscoinex/views/screens/auth/login/email_otp_screen.dart';
import 'package:masscoinex/views/screens/auth/login/login_screen.dart';
import 'package:masscoinex/views/screens/auth/login/login_screen_email.dart';
import 'package:masscoinex/views/screens/auth/login/mobile_verification_screen.dart';
import 'package:masscoinex/views/screens/auth/login/pin_screen.dart';
import 'package:masscoinex/views/screens/auth/login/reset_password_screen.dart';
import 'package:masscoinex/views/screens/auth/login/reset_pin_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/complete_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/email_otp_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/kyc_or_not_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/kyc_uploaded_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/mobile_verification_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/registration_details_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/registration_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/select_country_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/select_country_screen_after_registration.dart';
import 'package:masscoinex/views/screens/auth/registration/verify_select_country_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/dashboard_screens/dashboard_deposit_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/dashboard_screens/dashboard_history_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/dashboard_screens/dashboard_withdraw_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/mode_of_payment_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/bank/bank_transfer_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/card/card_payment_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/new_select_bank_and_branch/select_bank_screen.dart';
import 'package:masscoinex/views/screens/bottom_nav_screens/fiat_screens/payment_screens/upi/upi_payment_method_details_screen.dart';
import 'package:masscoinex/views/screens/currency_selected/currency_screens/transaction_history_screen.dart';
import 'package:masscoinex/views/screens/currency_selected/currency_selected_screen.dart';
import 'package:masscoinex/views/screens/main_screen.dart';
import 'package:masscoinex/views/screens/main_screen_copy.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/add_account/add_account_complete_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/add_account/nav_add_account_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/bank_list_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/card_list_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/new_logic/add_bank_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/new_logic/add_bank_screen_another.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/new_logic/add_card_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/new_logic_force/add_bank_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/new_logic_force/add_card_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/notification_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/security_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/support_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/verification_kyc/verify_kyc_uploaded_screen.dart';
import 'package:masscoinex/views/screens/nav_drawer_screens/verification_kyc/verify_registration_details_screen.dart';
import 'package:masscoinex/views/screens/new_logics/screens/currency_select_screen.dart';
import 'package:masscoinex/views/screens/new_logics/screens/currency_select_screen_force.dart';
import 'package:masscoinex/views/screens/new_logics/screens/verify_kyc_uploaded_screen.dart';
import 'package:masscoinex/views/screens/new_logics/screens/verify_registration_details_screen.dart';
import 'package:masscoinex/views/screens/security/change_password_screen.dart';
import 'package:masscoinex/views/screens/security/change_pin_screen.dart';
import 'package:masscoinex/views/screens/splash_screen.dart';

class Pages {
  static var pages = [
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: Routes.mainScreenCopy,
      page: () => MainScreenCopy(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.mobileVerification,
      page: () => MobileVerificationScreen(),
    ),
    GetPage(
      name: Routes.loginEmail,
      page: () => LoginEmailScreen(),
    ),
    GetPage(
      name: Routes.emailVerification,
      page: () => EmailOtpScreen(),
    ),
    GetPage(
      name: Routes.pinScreen,
      page: () => PinScreen(),
    ),
    GetPage(
      name: Routes.kycOrNot,
      page: () => KycOrNotScreen(),
    ),
    GetPage(
      name: Routes.registration,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: Routes.mobileVerificationRegistration,
      page: () => MobileVerificationRegistrationScreen(),
    ),
    GetPage(
      name: Routes.emailVerificationRegistration,
      page: () => EmailOtpRegistrationScreen(),
    ),
    GetPage(
      name: Routes.registrationDetails,
      page: () => RegistrationDetailsScreen(),
    ),
    GetPage(
      name: Routes.kycUploadedScreen,
      page: () => KycUploadedScreen(),
    ),
    GetPage(
      name: Routes.completeScreen,
      page: () => CompleteScreen(),
    ),
    GetPage(
      name: Routes.addAccount,
      page: () => AddAccountScreen(),
    ),
    GetPage(
      name: Routes.addAccountSuccessful,
      page: () => AddAccountCompleteScreen(),
    ),
    GetPage(
      name: Routes.currencySelected,
      page: () => CurrencySelectedScreen(),
    ),
    GetPage(
      name: Routes.modeOfPayment,
      page: () => ModeOfPaymentScreen(),
    ),
    /*GetPage(
      name: Routes.upiPayment,
      page: () => UPIPaymentScreen(),
    ),*/
    GetPage(
      name: Routes.getBanks,
      page: () => SelectBankScreen(),
    ),
    GetPage(
      name: Routes.bankPayment,
      page: () => BankTransferScreen(),
    ),
    GetPage(
      name: Routes.changePin,
      page: () => ChangePinScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.resetPin,
      page: () => ResetPinScreen(),
    ),
    GetPage(
      name: Routes.cardList,
      page: () => CardListScreen(),
    ),
    GetPage(
      name: Routes.bankList,
      page: () => BankListScreen(),
    ),
    /*GetPage(
      name: Routes.cardPayment,
      page: () => CardPaymentScreen(),
    ),*/
    GetPage(
      name: Routes.security,
      page: () => SecurityScreen(),
    ),
    GetPage(
      name: Routes.support,
      page: () => SupportScreen(),
    ),
    GetPage(
      name: Routes.dashboardHistory,
      page: () => DashboardHistoryScreen(),
    ),
    GetPage(
      name: Routes.dashboardDeposit,
      page: () => DashboardDepositScreen(),
    ),
    GetPage(
      name: Routes.dashboardWithdraw,
      page: () => DashboardWithdrawScreen(),
    ),
    GetPage(
      name: Routes.verifyKyc,
      page: () => VerifyRegistrationDetailsScreen(),
    ),
    GetPage(
      name: Routes.verifyKycUpload,
      page: () => VerifyKycUploadedScreen(),
    ),
    GetPage(
      name: Routes.transactionHistory,
      page: () => TransactionHistory(),
    ),
    GetPage(
      name: Routes.addCardOrBank,
      page: () => NavAddAccountScreen(),
    ),
    GetPage(
      name: Routes.addCardOrBankComplete,
      page: () => NavAddAccountCompleteScreen(),
    ),
    GetPage(
      name: Routes.selectCurrencyScreen,
      page: () => SelectCurrencyScreen(),
    ),
    GetPage(
      name: Routes.verifySelectCurrency,
      page: () => VerifySelectCurrencyScreen(),
    ),
    GetPage(
      name: Routes.selectCurrencyScreenAfterRegistration,
      page: () => SelectCurrencyScreenAfterRegistration(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => NotificationScreen(),
    ),
    /*New Logic starts*/
    GetPage(
      name: Routes.currencySelectNewLogic,
      page: () => CurrencySelectNewLogic(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.addBankNewLogic,
      page: () => AddBankScreenNewLogic(),
    ),
    GetPage(
      name: Routes.addCardNewLogic,
      page: () => AddCardScreenNewLogic(),
    ),
    GetPage(
      name: Routes.verifyKycNewLogic,
      page: () => VerifyRegistrationDetailsScreenNewLogicForce(),
    ),
    GetPage(
      name: Routes.verifyKycUploadNewLogic,
      page: () => VerifyKycUploadedScreenNewLogicForce(),
    ),
    GetPage(
      name: Routes.verifySelectCurrencyNewLogic,
      page: () => CurrencySelectNewLogicForce(),
    ),
    GetPage(
      name: Routes.addBankNewLogicForce,
      page: () => AddBankScreenNewLogicForce(),
    ),
    GetPage(
      name: Routes.addCardNewLogicForce,
      page: () => AddCardScreenNewLogicForce(),
    ),
    GetPage(
      name: Routes.addBankNewLogicAnother,
      page: () => AddBankScreenNewLogicAnother(),
    ),
  ];
}
