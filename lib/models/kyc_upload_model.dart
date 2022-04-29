// To parse this JSON data, do
//
//     final kycUploadModel = kycUploadModelFromJson(jsonString);

import 'dart:convert';

KycUploadModel kycUploadModelFromJson(String str) =>
    KycUploadModel.fromJson(json.decode(str));

String kycUploadModelToJson(KycUploadModel data) => json.encode(data.toJson());

class KycUploadModel {
  String? code;
  String? message;
  Result? result;

  KycUploadModel({
    this.code,
    this.message,
    this.result,
  });

  factory KycUploadModel.fromJson(Map<String, dynamic> json) => KycUploadModel(
        code: json["code"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result!.toJson(),
      };
}

class Result {
  List<Currencydatum> currencydata;

  Result({
    required this.currencydata,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        currencydata: List<Currencydatum>.from(
            json["currencydata"].map((x) => Currencydatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currencydata": List<dynamic>.from(currencydata.map((x) => x.toJson())),
      };
}

class Currencydatum {
  String currencyName;
  String currencyCode;
  String currencyImage;
  String currencyImagePath;

  Currencydatum({
    required this.currencyName,
    required this.currencyCode,
    required this.currencyImage,
    required this.currencyImagePath,
  });

  factory Currencydatum.fromJson(Map<String, dynamic> json) => Currencydatum(
        currencyName: json["currency_name"],
        currencyCode: json["currency_code"],
        currencyImage: json["currency_image"],
        currencyImagePath: json["currency_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "currency_name": currencyName,
        "currency_code": currencyCode,
        "currency_image": currencyImage,
        "currency_image_path": currencyImagePath,
      };
}
