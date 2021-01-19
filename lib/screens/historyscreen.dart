import 'dart:convert';

import 'package:digital_cash/models/transectionmodel.dart';
import 'package:digital_cash/models/usermodel.dart';
import 'package:digital_cash/pages/transections.dart';
import 'package:digital_cash/widgets/transectionitems.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  UserModel userModel = new UserModel();
  List<TransectionModel> transections = new List();
  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    if (phone != null) {
      var response = await http.get(
        'https://phonepe.technopowerz.com/get_user_data?phone=$phone',
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
        'https://phonepe.technopowerz.com/get_transections?username=$username',
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'All Transections',
              style: TextStyle(
                color: Color(0xff707070),
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
