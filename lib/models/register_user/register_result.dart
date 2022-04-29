class RegisterResult {
  String fullName;
  String email;
  String password;
  String pin;
  String phone;
  String country;
  String termsCondition;
  String privacyPolicy;
  String amlKyc;
  String notify;
  String userType;
  dynamic referralCode;
  String userCode;
  DateTime updatedAt;
  DateTime createdAt;
  String id;
  String token;
  RegisterResult({
    required this.fullName,
    required this.email,
    required this.password,
    required this.pin,
    required this.phone,
    required this.country,
    required this.termsCondition,
    required this.privacyPolicy,
    required this.amlKyc,
    required this.notify,
    required this.userType,
    required this.referralCode,
    required this.userCode,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.token,
  });

  factory RegisterResult.fromJson(Map<String, dynamic> json) => RegisterResult(
        fullName: json["full_name"],
        email: json["email"],
        password: json["password"],
        pin: json["pin"],
        phone: json["phone"],
        country: json["country"],
        termsCondition: json["terms_condition"],
        privacyPolicy: json["privacy_policy"],
        amlKyc: json["aml_kyc"],
        notify: json["notify"],
        userType: json["user_type"],
        referralCode: json["referral_code"],
        userCode: json["user_code"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "password": password,
        "pin": pin,
        "phone": phone,
        "country": country,
        "terms_condition": termsCondition,
        "privacy_policy": privacyPolicy,
        "aml_kyc": amlKyc,
        "notify": notify,
        "user_type": userType,
        "referral_code": referralCode,
        "user_code": userCode,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "token": token,
      };
}
