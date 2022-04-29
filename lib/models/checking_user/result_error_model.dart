class ResultError {
  ResultError({
    required this.error,
  });

  String error;

  factory ResultError.fromJson(Map<String, dynamic> json) => ResultError(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
