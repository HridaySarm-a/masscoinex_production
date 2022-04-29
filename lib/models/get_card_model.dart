class GetCardModel {
  GetCardModel({
    required this.code,
    required this.message,
    required this.result,
  });
  late final String code;
  late final String message;
  late final List<Result> result;

  GetCardModel.fromJson(Map<String, dynamic> json){
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
    required this.nameOnCard,
    required this.billingAddress,
    required this.telephone,
    required this.country,
    required this.cardNumber,
    required this.cardType,
    required this.cardExpiry,
    required this.cardCvc,
    this.state,
    this.city,
    this.zip,
    this.videoName,
    required this.cardStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final dynamic nameOnCard;
  late final dynamic billingAddress;
  late final dynamic telephone;
  late final dynamic country;
  late final dynamic cardNumber;
  late final dynamic cardType;
  late final dynamic cardExpiry;
  late final dynamic cardCvc;
  late final dynamic state;
  late final dynamic city;
  late final dynamic zip;
  late final dynamic videoName;
  late final dynamic cardStatus;
  late final dynamic createdAt;
  late final dynamic updatedAt;

  Result.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    nameOnCard = json['name_on_card'];
    billingAddress = json['billing_address'];
    telephone = json['telephone'];
    country = json['country'];
    cardNumber = json['card_number'];
    cardType = json['card_type'];
    cardExpiry = json['card_expiry'];
    cardCvc = json['card_cvc'];
    state = json['state'];
    city =json['city'];
    zip = json['zip'];
    videoName = json['video_name'];
    cardStatus = json['card_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['name_on_card'] = nameOnCard;
    _data['billing_address'] = billingAddress;
    _data['telephone'] = telephone;
    _data['country'] = country;
    _data['card_number'] = cardNumber;
    _data['card_type'] = cardType;
    _data['card_expiry'] = cardExpiry;
    _data['card_cvc'] = cardCvc;
    _data['state'] = state;
    _data['city'] = city;
    _data['zip'] = zip;
    _data['video_name'] = videoName;
    _data['card_status'] = cardStatus;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}