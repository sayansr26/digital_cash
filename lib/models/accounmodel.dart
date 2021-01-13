class AccountModel {
  String banificary;
  String account;
  String ifsc;
  String bankname;
  String phone;
  String date;

  AccountModel({
    this.banificary,
    this.account,
    this.ifsc,
    this.bankname,
    this.phone,
    this.date,
  });

  factory AccountModel.fromMap(Map<String, dynamic> jsonData) {
    return AccountModel(
      banificary: jsonData['banificary'],
      account: jsonData['account'],
      ifsc: jsonData['ifsc'],
      bankname: jsonData['bank_name'],
      phone: jsonData['phone'],
      date: jsonData['date'],
    );
  }
}
