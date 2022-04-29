class SupportModel {
  SupportModel({
    required this.code,
    required this.message,
    required this.result,
  });
  late final String code;
  late final String message;
  late final Result result;

  SupportModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['result'] = result.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.id,
    required this.telephone1,
    required this.telephone2,
    required this.email1,
    required this.email2,
    required this.liveConnect1,
    required this.liveConnect2,
  });
  late final int id;
  late final String telephone1;
  late final String telephone2;
  late final String email1;
  late final String email2;
  late final String liveConnect1;
  late final String liveConnect2;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    telephone1 = json['telephone1'];
    telephone2 = json['telephone2'];
    email1 = json['email1'];
    email2 = json['email2'];
    liveConnect1 = json['live_connect1'];
    liveConnect2 = json['live_connect2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['telephone1'] = telephone1;
    _data['telephone2'] = telephone2;
    _data['email1'] = email1;
    _data['email2'] = email2;
    _data['live_connect1'] = liveConnect1;
    _data['live_connect2'] = liveConnect2;
    return _data;
  }
}