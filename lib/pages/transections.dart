import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Transections extends StatefulWidget {
  final String banificary,
      id,
      account,
      ifsc,
      bank,
      amount,
      charges,
      total,
      orderId,
      status,
      date;
  Transections({
    this.id,
    this.banificary,
    this.account,
    this.ifsc,
    this.bank,
    this.amount,
    this.charges,
    this.total,
    this.orderId,
    this.status,
    this.date,
  });

  @override
  _TransectionsState createState() => _TransectionsState();
}

class _TransectionsState extends State<Transections> {
  TextEditingController banificaryController = new TextEditingController();
  TextEditingController accountController = new TextEditingController();
  TextEditingController ifscController = new TextEditingController();
  TextEditingController bankController = new TextEditingController();
  TextEditingController orderController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();

  addValues() {
    if (widget.banificary != null) {
      banificaryController.text = widget.banificary;
      accountController.text = widget.account;
      ifscController.text = widget.ifsc;
      bankController.text = widget.bank;
      orderController.text = widget.orderId;
      statusController.text = widget.status;
    }
  }

  @override
  void initState() {
    super.initState();
    addValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xff707070),
        ),
        centerTitle: true,
        title: Text(
          'Sent',
          style: TextStyle(
            color: Color(0xff707070),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Outgoing Transection',
                style: TextStyle(
                  color: Color(0xff707070),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xffa3d593),
                  child: Icon(
                    Feather.user,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  widget.banificary,
                  style: TextStyle(
                    color: Color(0xff707070),
                  ),
                ),
                subtitle: Text(widget.date),
                trailing: Text(
                  '- ₹ ${widget.amount}.00',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Details',
                style: TextStyle(
                  color: Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff707070),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      MaterialCommunityIcons.bank_transfer,
                      color: Color(0xfff0f0f0),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Bank Transfer',
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              TextField(
                controller: banificaryController,
                readOnly: true,
                style: TextStyle(
                  color: Color(0xff707070),
                ),
                decoration: InputDecoration(
                  labelText: 'Banificary Name',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                controller: accountController,
                readOnly: true,
                style: TextStyle(
                  color: Color(0xff707070),
                ),
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                controller: ifscController,
                readOnly: true,
                style: TextStyle(
                  color: Color(0xff707070),
                ),
                decoration: InputDecoration(
                  labelText: 'IFSC Code',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                controller: bankController,
                readOnly: true,
                style: TextStyle(
                  color: Color(0xff707070),
                ),
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                controller: orderController,
                readOnly: true,
                style: TextStyle(
                  color: Color(0xff707070),
                ),
                decoration: InputDecoration(
                  labelText: 'Transection Id',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                controller: statusController,
                readOnly: true,
                style: TextStyle(
                  color: Color(0xff707070),
                ),
                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
