import 'package:flutter/material.dart';

class FiatHistoryModel {
  int id;
  String title;
  String transactionID;
  String date;
  String money;
  String status;
  Color statusColor;
  FiatHistoryModel({
    required this.id,
    required this.title,
    required this.transactionID,
    required this.date,
    required this.money,
    required this.status,
    required this.statusColor,
  });
}
