class TransectionModel {
  String id;
  String amount;
  String charge;
  String total;
  String type;
  String date;
  String username;
  String ban;
  String account;
  String ifsc;
  String bank;
  String razorpay;
  String transectionid;
  String status;

  TransectionModel({
    this.id,
    this.amount,
    this.charge,
    this.total,
    this.type,
    this.date,
    this.username,
    this.ban,
    this.account,
    this.ifsc,
    this.bank,
    this.razorpay,
    this.transectionid,
    this.status,
  });

  factory TransectionModel.fromMap(Map<String, dynamic> jsonData) {
    return TransectionModel(
      id: jsonData['id'],
      amount: jsonData['amount'],
      charge: jsonData['charge'],
      total: jsonData['total'],
      type: jsonData['type'],
      date: jsonData['date'],
      username: jsonData['username'],
      ban: jsonData['ban'],
      account: jsonData['account'],
      ifsc: jsonData['ifsc'],
      bank: jsonData['bank'],
      razorpay: jsonData['razorpay'],
      transectionid: jsonData['transectionid'],
      status: jsonData['status'],
    );
  }
}
