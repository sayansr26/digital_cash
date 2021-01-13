import 'dart:convert';

import 'package:digital_cash/models/transectionmodel.dart';
import 'package:digital_cash/models/usermodel.dart';
import 'package:digital_cash/pages/transections.dart';
import 'package:digital_cash/pages/transfer.dart';
import 'package:digital_cash/widgets/transectionitems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  UserModel userModel = new UserModel();
  List<TransectionModel> transections = new List();
  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    if (phone != null) {
      var response = await http.get(
        'https://tubeace.ml/get_user_data?phone=$phone',
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      userModel = UserModel.fromMap(jsonData['result']);

      setState(() {});
      getTransections();
    }
  }

  getTransections() async {
    var username = userModel.username;
    if (username != null) {
      var response = await http.get(
        'https://tubeace.ml/get_transections?username=$username',
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData['result'].forEach((element) {
        TransectionModel transectionModel = new TransectionModel();
        transectionModel = TransectionModel.fromMap(element);
        transections.add(transectionModel);
      });

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Transfer(),
            ),
          );
        },
        backgroundColor: Color(0xffff7a7a),
        child: Icon(MaterialCommunityIcons.bank_transfer),
      ),
      body: Container(
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height / 2.3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffa3d593),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/icons/wallet-transfer.png'),
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '₹ ${userModel.balance}.00',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Changa',
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount:
                      (transections.length != null) ? transections.length : 0,
                  itemBuilder: (context, index) {
                    return TransectionItems(
                      transferAmount: '₹ ${transections[index].amount}.00',
                      transferDate: transections[index].date,
                      transferType: (transections[index].type == '1')
                          ? 'Transfer Out'
                          : 'Transfer In',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Transections(
                              banificary: transections[index].ban,
                              account: transections[index].account,
                              ifsc: transections[index].ifsc,
                              bank: transections[index].bank,
                              amount: transections[index].amount,
                              charges: transections[index].charge,
                              total: transections[index].total,
                              orderId: transections[index].transectionid,
                              status: transections[index].status,
                              date: transections[index].date,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  WalletCard({
    @required this.balance,
    @required this.deposite,
    @required this.withdrawl,
  });
  final String balance, deposite, withdrawl;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text('BALANCE DETAILS'),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    balance,
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Changa',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Deposite'),
                      Text(
                        deposite,
                        style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Transfer'),
                      Text(
                        withdrawl,
                        style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Changa',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
