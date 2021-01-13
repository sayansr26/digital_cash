import 'dart:convert';

import 'package:digital_cash/models/transectionmodel.dart';
import 'package:digital_cash/models/usermodel.dart';
import 'package:digital_cash/pages/transections.dart';
import 'package:digital_cash/pages/transfer.dart';
import 'package:digital_cash/screens/historyscreen.dart';
import 'package:digital_cash/screens/walletscreen.dart';
import 'package:digital_cash/widgets/transectionitems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      // print(jsonData['result']);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            color: Color(0xffff7a7a),
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        (userModel.fname != null)
                            ? Text(
                                userModel.fname.toUpperCase(),
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 18,
                                ),
                              )
                            : Text(
                                'USER',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 18,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Image(
                      image: AssetImage('assets/icons/walletwelcome.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 1.4,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffa3d593),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Transfer(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Feather.send),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WalletScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(FlutterIcons.wallet_plus_mco),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(FlutterIcons.bank_transfer_mco),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Resent Transections',
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Color(0xffff7a7a),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    (transections.length == null) ? 0 : transections.length,
                itemBuilder: (context, index) {
                  return TransectionItems(
                    transferType: (transections[index].type == '1')
                        ? 'Transfer Out'
                        : 'Transfer In',
                    transferAmount: '₹ ${transections[index].amount}.00',
                    transferDate: transections[index].date,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Transections(
                            id: transections[index].id,
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
          ],
        ),
      ),
    );
  }
}
