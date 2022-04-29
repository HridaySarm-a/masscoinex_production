// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String code;
  String message;
  Result result;
  ProfileModel({
    required this.code,
    required this.message,
    required this.result,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result.toJson(),
      };
}

class Result {
  String id;
  String userCode;
  dynamic referralCode;
  String userType;
  String fullName;
  String companyName;
  String ownerName;
  String email;
  String companyEmail;
  String password;
  String pin;
  String phone;
  dynamic dob;
  dynamic address;
  String companyPhone;
  String city;
  String state;
  String postcode;
  String country;
  String hear;
  String notify;
  String termsCondition;
  String privacyPolicy;
  String amlKyc;
  String otp;
  String imageName;
  String onlineStatus;
  String employeeStatus;
  String kycStatus;
  String google2FaSecret;
  String rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  Result({
    required this.id,
    required this.userCode,
    required this.referralCode,
    required this.userType,
    required this.fullName,
    required this.companyName,
    required this.ownerName,
    required this.email,
    required this.companyEmail,
    required this.password,
    required this.pin,
    required this.phone,
    required this.dob,
    required this.address,
    required this.companyPhone,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.hear,
    required this.notify,
    required this.termsCondition,
    required this.privacyPolicy,
    required this.amlKyc,
    required this.otp,
    required this.imageName,
    required this.onlineStatus,
    required this.employeeStatus,
    required this.kycStatus,
    required this.google2FaSecret,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userCode: json["user_code"],
        referralCode: json["referral_code"],
        userType: json["user_type"],
        fullName: json["full_name"],
        companyName: json["company_name"],
        ownerName: json["owner_name"],
        email: json["email"],
        companyEmail: json["company_email"],
        password: json["password"],
        pin: json["pin"],
        phone: json["phone"],
        dob: json["dob"],
        address: json["address"],
        companyPhone: json["company_phone"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        hear: json["hear"],
        notify: json["notify"],
        termsCondition: json["terms_condition"],
        privacyPolicy: json["privacy_policy"],
        amlKyc: json["aml_kyc"],
        otp: json["otp"],
        imageName: json["image_name"],
        onlineStatus: json["online_status"],
        employeeStatus: json["employee_status"],
        kycStatus: json["kyc_status"],
        google2FaSecret: json["google2fa_secret"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_code": userCode,
        "referral_code": referralCode,
        "user_type": userType,
        "full_name": fullName,
        "company_name": companyName,
        "owner_name": ownerName,
        "email": email,
        "company_email": companyEmail,
        "password": password,
        "pin": pin,
        "phone": phone,
        "dob": dob,
        "address": address,
        "company_phone": companyPhone,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "hear": hear,
        "notify": notify,
        "terms_condition": termsCondition,
        "privacy_policy": privacyPolicy,
        "aml_kyc": amlKyc,
        "otp": otp,
        "image_name": imageName,
        "online_status": onlineStatus,
        "employee_status": employeeStatus,
        "kyc_status": kycStatus,
        "google2fa_secret": google2FaSecret,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
