class Result {
  String otp;
  String email;
  String password;
  String pin;
  Result({
    required this.otp,
    required this.email,
    required this.password,
    required this.pin,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        otp: json["otp"],
        email: json["email"],
        password: json["password"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "email": email,
        "password": password,
        "pin": pin,
      };
}
