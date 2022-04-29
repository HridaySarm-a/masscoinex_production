import 'bank_code_data.dart';

/// code : "1"
/// message : "Bank Codes List."
/// result : [{"bank_codename":"SWIFT"},{"bank_codename":"FINANCIAL INSTITUTION NUMBER"},{"bank_codename":"TRANSIT NUMBER"}]

class BankCodeResponse {
  BankCodeResponse({
    String? code,
    String? message,
    List<BankCodeResult>? result,
  }) {
    _code = code;
    _message = message;
    _result = result;
  }

  BankCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(BankCodeResult.fromJson(v));
      });
    }
  }

  String? _code;
  String? _message;
  List<BankCodeResult>? _result;

  String? get code => _code;

  String? get message => _message;

  List<BankCodeResult>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// bank_codename : "SWIFT"
