class ResetModel {
  ResetModel({
    required this.code,
    required this.message,
    required this.result,
  });
  late final String code;
  late final String message;
  late final String result;

  ResetModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['result'] = result;
    return _data;
  }
}