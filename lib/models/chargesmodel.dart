class ChargesModel {
  String currency;
  String charge;

  ChargesModel({
    this.currency,
    this.charge,
  });

  factory ChargesModel.fromMap(Map<String, dynamic> jsonData) {
    return ChargesModel(
      currency: jsonData['currency'],
      charge: jsonData['rate'],
    );
  }
}
