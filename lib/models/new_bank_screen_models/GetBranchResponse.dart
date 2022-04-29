/// code : "1"
/// message : "Payment Mode Data"
/// mode_data_fields : [{"id":1,"countrywise_bank_company_id":1,"field_name":"Bank Name:","field_value":"HDFC BANK LIMITED","created_at":null,"updated_at":null},{"id":2,"countrywise_bank_company_id":1,"field_name":"Bank Address:","field_value":"38, Chetla Central Road, Chetla, Kolkata, West Bengal, 700027, India","created_at":null,"updated_at":null},{"id":3,"countrywise_bank_company_id":1,"field_name":"Beneficiary Account Name:1","field_value":"NIKHAT INDUSTRIES PRIVATE LIMITED","created_at":null,"updated_at":null},{"id":4,"countrywise_bank_company_id":1,"field_name":"Beneficiary Account Number","field_value":"50200049543988","created_at":null,"updated_at":null},{"id":5,"countrywise_bank_company_id":1,"field_name":"Beneficiary Bank SWIFT:","field_value":"HDFCINBBCAL","created_at":null,"updated_at":null},{"id":6,"countrywise_bank_company_id":1,"field_name":"Beneficiary Address:","field_value":"Kolkata, India","created_at":null,"updated_at":null},{"id":7,"countrywise_bank_company_id":1,"field_name":"Reference Number:","field_value":"","created_at":null,"updated_at":null}]

class GetBranchResponse {
  GetBranchResponse({
      String? code, 
      String? message, 
      List<ModeDataFields>? modeDataFields,}){
    _code = code;
    _message = message;
    _modeDataFields = modeDataFields;
}

  GetBranchResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['mode_data_fields'] != null) {
      _modeDataFields = [];
      json['mode_data_fields'].forEach((v) {
        _modeDataFields?.add(ModeDataFields.fromJson(v));
      });
    }
  }
  String? _code;
  String? _message;
  List<ModeDataFields>? _modeDataFields;

  String? get code => _code;
  String? get message => _message;
  List<ModeDataFields>? get modeDataFields => _modeDataFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_modeDataFields != null) {
      map['mode_data_fields'] = _modeDataFields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// countrywise_bank_company_id : 1
/// field_name : "Bank Name:"
/// field_value : "HDFC BANK LIMITED"
/// created_at : null
/// updated_at : null

class ModeDataFields {
  ModeDataFields({
      int? id, 
      int? countrywiseBankCompanyId, 
      String? fieldName, 
      String? fieldValue, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _countrywiseBankCompanyId = countrywiseBankCompanyId;
    _fieldName = fieldName;
    _fieldValue = fieldValue;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  ModeDataFields.fromJson(dynamic json) {
    _id = json['id'];
    _countrywiseBankCompanyId = json['countrywise_bank_company_id'];
    _fieldName = json['field_name'];
    _fieldValue = json['field_value'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _countrywiseBankCompanyId;
  String? _fieldName;
  String? _fieldValue;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  int? get countrywiseBankCompanyId => _countrywiseBankCompanyId;
  String? get fieldName => _fieldName;
  String? get fieldValue => _fieldValue;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countrywise_bank_company_id'] = _countrywiseBankCompanyId;
    map['field_name'] = _fieldName;
    map['field_value'] = _fieldValue;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}