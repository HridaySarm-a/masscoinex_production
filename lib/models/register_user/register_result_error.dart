class RegisterResultError {
    RegisterResultError({
        required this.email,
    });

    List<String> email;

    factory RegisterResultError.fromJson(Map<String, dynamic> json) => RegisterResultError(
        email: List<String>.from(json["email"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
    };
}
