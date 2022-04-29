class ApiRoutes {
  static const baseUrl = "https://test.masscoinex.com/api/";
  static const checkingUser = "checking-user";
  static const register = "register";
  static const login = "login";
  static const dashboard = "dashboard";
  static const dashboardData = "dashboard-data";
  static const kycUpgrade = "kyc-upgrade";
  static const currencySetup = "currency-setup";
  static const profileInfo = "get-profile";
  static const profileUpdate = "update-profile";
  static const addBank = "add-bank";
  static const updatePhoto = "update-photo";
  static const currencyList = "currency-list";

  /* Buy */
  static const getFiatCryptoValue = "get-fiat-crypto-value";
  static const getFiatCryptoAmount = "get-fiat-crypto-amount";
  static const getBuyCryptoFiatPercentValueGetFiatCryptoAmount = "get-buy-crypto-fiat-percent-value";
  static const buyFiatToCrypto = "buy-fiat-to-crypto";
  static const history = "crypto-transaction-history";

  /*Sell*/
  static const getFiatSellCryptoValue = "get-fiat-sell-crypto-value";
  static const getFiatSellCryptoAmount = "get-fiat-sell-crypto-amount";
  static const saveSellCrypto = "save-sell-crypto";
  static const getPercentSellCryptoValue = "get-percent-sell-crypto-value";

  /*Withdraw*/
  static const getFiatWithdrawCryptoValue = "get-fiat-withdraw-crypto-value";
  static const saveWithdrawCrypto = "save-withdraw-crypto";
  static const getPercentWithdrawCryptoValue = "get-percent-withdraw-crypto-value";

  /*Deposit*/
  static const getFiatRequestCryptoAmount = "get-fiat-request-crypto-amount";
  static const saveRequestCrypto = "save-request-crypto";

  /*Swap*/
  static const getUserCryptoCoins = "get-user-crypto-coins";
  static const getFiatSwapCryptoAmount = "get-fiat-swap-crypto-amount";
  static const saveSwapCrypto = "save-swap-crypto";
  static const getPercentSwapCryptoAmount = "get-percent-swap-crypto-value";

  /*Fiat*/
  static const fiatTransactionHistory = "fiat-transaction-history";
  /*Deposit*/
  static const deposit = "deposit";
  static const getDepositFee = "get-deposit-fee";

  /*Withdraw*/
  static const getWithdrawFee = "get-withdraw-fee";
  static const withdrawConfirmation = "withdraw-confirmation";
  static const saveWithdraw = "save-withdraw";

  /*Payment Mode List*/
  static const paymentModeList = "payment-mode-list";

  /*Add Card*/
  static const addCard = "add-card";
  static const cardDocument = "card-document";

  /*Payment Method*/
  static const paymentMethod = "payment-method";
  static const paymentMethodDetails = "payment-method-details";
  static const depositConfirmation = "deposit-confirmation";
  static const saveDeposit = "save-deposit";

  /*Get Banks*/
  static const getBanks = "get-banks";

  /*Get cards*/
  static const getCards = "get-cards";

  /*Get Support*/
  static const support = "support";
  /*Security*/
  static const resetPin = "reset-pin";
  static const changePassword = "change-password";

  /*About Us*/
  static const aboutUs = "about-app";

  /*Login*/
  static const resetPassword = "reset-user-password";
  static const resetUserPin = "reset-user-pin";
  static const logout = "logout";
  static const deactivate = "deactivate-account";
}

// This is UI beta test
