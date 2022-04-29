import 'package:get/get.dart';

class CurrencySelectorListModel {
  int id;
  String money;
  String values;
  RxBool isSelected;
  CurrencySelectorListModel({
    required this.id,
    required this.money,
    required this.values,
    required this.isSelected,
  });
}
