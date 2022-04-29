/// code : "1"
/// message : "Payment Mode Data"
/// payment_methods : [{"id":1,"bank_name":"HDFC","status":"Active","created_at":null,"updated_at":null},{"id":2,"bank_name":"ICICI","status":"Active","created_at":null,"updated_at":null}]

class GetBanksResponse {
  GetBanksResponse({
      String? code, 
      String? message, 
      List<PaymentMethods>? paymentMethods,}){
    _code = code;
    _message = message;
    _paymentMethods = paymentMethods;
}

  GetBanksResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payment_methods'] != null) {
      _paymentMethods = [];
      json['payment_methods'].forEach((v) {
        _paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
  }
  String? _code;
  String? _message;
  List<PaymentMethods>? _paymentMethods;

  String? get code => _code;
  String? get message => _message;
  List<PaymentMethods>? get paymentMethods => _paymentMethods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_paymentMethods != null) {
      map['payment_methods'] = _paymentMethods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// bank_name : "HDFC"
/// status : "Active"
/// created_at : null
/// updated_at : null

class PaymentMethods {
  PaymentMethods({
      int? id, 
      String? bankName, 
      String? status, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _bankName = bankName;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  PaymentMethods.fromJson(dynamic json) {
    _id = json['id'];
    _bankName = json['bank_name'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _bankName;
  String? _status;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get bankName => _bankName;
  String? get status => _status;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bank_name'] = _bankName;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}