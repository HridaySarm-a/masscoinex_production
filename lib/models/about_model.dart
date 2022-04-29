class AboutModel {
  AboutModel({
    required this.code,
    required this.message,
    required this.result,
  });
  late final String code;
  late final String message;
  late final Result result;

  AboutModel.fromJson(Map<String, dynamic> json){
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
    required this.app,
    required this.version,
  });
  late final int id;
  late final String app;
  late final String version;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    app = json['app'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['app'] = app;
    _data['version'] = version;
    return _data;
  }
}