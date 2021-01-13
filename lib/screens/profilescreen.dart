import 'dart:convert';

import 'package:digital_cash/models/usermodel.dart';
import 'package:digital_cash/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AssetImage userImage = AssetImage('assets/icons/man.png');

  UserModel userModel = new UserModel();
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
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Center(
              child: Image(
                image: userImage,
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${userModel.fname} ${userModel.lname}',
              style: TextStyle(
                color: Color(0xff707070),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${userModel.email}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _launchURL('https://digitalcash24.com/');
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.8,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xffff7a7a),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Access Web Version',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(
                      FlutterIcons.globe_asia_faw5s,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.11),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.privacy_tip_sharp,
                ),
                title: Text(
                  'Privacy & Policy',
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(AntDesign.arrowright),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.11),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  int phone = 916289572156;
                  _launchURL('whatsapp://send?phone=$phone');
                },
                leading: Icon(
                  FontAwesome.support,
                ),
                title: Text(
                  'Help & Support',
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(AntDesign.arrowright),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.11),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {},
                leading: Icon(
                  AntDesign.edit,
                ),
                title: Text(
                  'Request A Change',
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(AntDesign.arrowright),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.11),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove('phone');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                    (route) => false,
                  );
                },
                leading: Icon(
                  Icons.exit_to_app,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(AntDesign.arrowright),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
