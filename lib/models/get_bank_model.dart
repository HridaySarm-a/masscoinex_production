class GetBankModel {
  GetBankModel({
    required this.code,
    required this.message,
    required this.result,
  });
  late final String code;
  late final String message;
  late final List<Result> result;

  GetBankModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['result'] = result.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.userId,
    required this.bankName,
    required this.bankAddress,
    this.bankState,
    required this.bankCity,
    required this.bankZip,
    required this.bankCode,
    this.bankTelephone,
    required this.fullName,
    required this.accountNo,
    required this.bankStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  late final dynamic id;
  late final dynamic userId;
  late final dynamic bankName;
  late final dynamic bankAddress;
  late final dynamic bankState;
  late final dynamic bankCity;
  late final dynamic bankZip;
  late final dynamic bankCode;
  late final dynamic bankTelephone;
  late final dynamic fullName;
  late final dynamic accountNo;
  late final dynamic bankStatus;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    bankAddress = json['bank_address'];
    bankState = json['bank_state'];
    bankCity = json['bank_city'];
    bankZip = json['bank_zip'];
    bankCode = json['bank_code'];
    bankTelephone = json['bank_telephone'];
    fullName = json['full_name'];
    accountNo = json['account_no'];
    bankStatus = json['bank_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['bank_name'] = bankName;
    _data['bank_address'] = bankAddress;
    _data['bank_state'] = bankState;
    _data['bank_city'] = bankCity;
    _data['bank_zip'] = bankZip;
    _data['bank_code'] = bankCode;
    _data['bank_telephone'] = bankTelephone;
    _data['full_name'] = fullName;
    _data['account_no'] = accountNo;
    _data['bank_status'] = bankStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}