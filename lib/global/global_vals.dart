import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GlobalVals {
  static const backgroundColor = Color(0xFF5C28AF);
  static const appbarColor = Color(0xFF5c28b0);
  static const bottomNavSelectedColor = Color(0xFFf7499e);
  static const raiseColor = 0xFF71b553;
  static const downColor = 0xFFe07978;
  static const buttonColor = Color(0xFF5c28b0);
  static const textColor = Colors.blue;
  static const currencyColor = Color(0xFF4d16a8);

  //?Hive Texts
  static const hiveBox = "masscoinex";
  static const checkLogin = "checkLogin";
  static const register = "register";
  static const user = "user";
  static const dashBoard = "dashBoard";
  static const dashBoardData = "dashBoardData";
  static const kycUploadModel = "kycUploadModel";
  static const profileInfo = "profileInfo";
  static const buyCryptos = "buyCryptos";
  static const isLoggedIn = "isLoggedIn";
  static const addCard = "add-card";
  static const deposit = "deposit";
  static const withdrawAmount = "withdrawAmount";
  static const selectedPaymentMode = "selectedPaymentMode";
  static const paymentMethodId = "payment-method-id";
  static const paymentMethodName = "payment-method-name";
  static const referenceNo = "referenceNo";
  static const tempToken = "tempToken";

  static const duration = Duration(seconds: 3);

  //?ErrorToast
  static errorToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static successToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  //?Default Bearer Token
  static const defaultToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjRiNmNiNzg3OGI5NWQ4NDQ0ZjMyYmJiZDVkZDFjYjQ2YmYyMmY2MjZjZDljNjU2MDYzMWExZTdmYzA5NjEwZTM0YzZjNWMxYzJkOTk2NmUwIn0.eyJhdWQiOiIxIiwianRpIjoiNGI2Y2I3ODc4Yjk1ZDg0NDRmMzJiYmJkNWRkMWNiNDZiZjIyZjYyNmNkOWM2NTYwNjMxYTFlN2ZjMDk2MTBlMzRjNmM1YzFjMmQ5OTY2ZTAiLCJpYXQiOjE2MzAwODYzMTcsIm5iZiI6MTYzMDA4NjMxNywiZXhwIjoxNjYxNjIyMzE3LCJzdWIiOiIxODA0Iiwic2NvcGVzIjpbXX0.TwfIZ3qwAhxIze1jiMeBqXVWOqG_-TI_jI2ltwYgsrEivROymuyM5ftNhY5VF3wO1EnYWEpq78CZ8_q-Vrq1_K3eo0bNUS-vy3q62H-rU2w02HvYqpTfodgMvavHIG_8w9Mg_2xvRaUy3OrRJO-W2YfZm2wc8gP4ulJCq7E2X95gEX1zCWB5gLHbS3t992zFiQXrYnOOIeih4fM8VciLViisuqknzaum_BXBhIT3SYR0PJCRm13m0nEAmXKwDtonAag-hxSnJ5ZrgPgZNbIeaxjjahDZss5_9K5GYnQs5-uThN-3K542osMVO5b-aqz6Mjf0CMFS_BKXpNNDYU7_oKNaVq_p7WztwHXaKXGXCtVODZeQHG9iuph5E6NRstmy26wKi_SgK5OdJ7k9Gjl8m6W4N9-ZRM9GJgjswqQ2sYXDhcupd7taWqfYO8YZvHQdemjxInWZJzF9JUeUwgdzoBMUf64PEWIm_ZtLs41M3--qygLsa2QsMfgqkWtKnnLX8j6YjLcOm5YTDfcbtS6E_dL_ICgHOHRh2WNo0sVyvQVozOs-fxUCPwOcXUcNe3VokgPWHtBz11WbniM365ZtK6LpiifexoVekTcoYJ6jfyCR-I1RjZTdKbF7eg0S3g2RstfJTOMkzqsDupNt2cgtRLDa7HPqrl6QENOhb6jTbQU";
}
