class OrdersModel {
  String id;
  String entity;
  int amount;
  int amountpaid;
  int amountdue;
  String currency;
  String recipt;
  String offerid;
  String status;
  int attempts;
  List notes;
  int createdat;

  OrdersModel({
    this.id,
    this.entity,
    this.amount,
    this.amountpaid,
    this.amountdue,
    this.currency,
    this.recipt,
    this.offerid,
    this.status,
    this.attempts,
    this.notes,
    this.createdat,
  });

  factory OrdersModel.fromMap(Map<String, dynamic> jsonData) {
    return OrdersModel(
      id: jsonData['id'],
      entity: jsonData['entity'],
      amount: jsonData['amount'],
      amountpaid: jsonData['amount_paid'],
      amountdue: jsonData['amount_due'],
      currency: jsonData['currency'],
      recipt: jsonData['receipt'],
      offerid: jsonData['offer_id'],
      status: jsonData['status'],
      attempts: jsonData['attempts'],
      createdat: jsonData['created_at'],
    );
  }
}
