// To parse this JSON data, do
//
//     final buyModel = buyModelFromJson(jsonString);

import 'dart:convert';

BuyModel buyModelFromJson(String str) => BuyModel.fromJson(json.decode(str));

String buyModelToJson(BuyModel data) => json.encode(data.toJson());

class BuyModel {
    BuyModel({
        this.code,
        this.message,
        this.result,
    });

    String? code;
    String? message;
    String? result;

    factory BuyModel.fromJson(Map<String, dynamic> json) => BuyModel(
        code: json["code"],
        message: json["message"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result,
    };
}
