
class BankCodeResult {
  BankCodeResult({
    String? bankCodename,
  }) {
    _bankCodename = bankCodename;
  }

  BankCodeResult.fromJson(dynamic json) {
    _bankCodename = json['bank_codename'];
  }

  String? _bankCodename;

  String? get bankCodename => _bankCodename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank_codename'] = _bankCodename;
    return map;
  }
}
