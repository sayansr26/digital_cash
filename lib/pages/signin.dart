import 'dart:convert';

import 'package:digital_cash/pages/otp.dart';
import 'package:digital_cash/pages/signup.dart';
import 'package:digital_cash/widgets/buttongetstarted.dart';
import 'package:digital_cash/widgets/formtitle.dart';
import 'package:digital_cash/widgets/inputbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  AssetImage bgImage = AssetImage('assets/images/signup-bg.png');
  AssetImage logo = AssetImage('assets/images/logo.png');
  TextEditingController _phoneController = TextEditingController();

  String phone, type;
  String successCode = "";

  getStat(String phone) async {
    var response = await http.get(
      "https://phonepe.technopowerz.com/check_stat?phone=$phone",
      headers: {"Accept": "application/json"},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    setState(() {
      successCode = jsonData['success'];
    });
  }

  void showSnackbar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Color(0xfff0f0f0),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height / 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: bgImage,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: logo,
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'Digital Cash 24',
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontFamily: 'RacingSansOne',
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'Hand crafted wallet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'RacingSansOne',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: size.height / 1.8,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormTitle(
                    title: 'Welcome Back',
                    subTitle: 'Sign In to continue',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputBox(
                    placeholder: 'Phone',
                    textInputType: TextInputType.number,
                    iconData: FontAwesome5Solid.phone,
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ButtonGetStarted(
                      buttonText: 'Sign In',
                      onPressed: () async {
                        phone = _phoneController.text;
                        type = '2';
                        if (phone == '') {
                          showSnackbar('Phone nmuber required !');
                        } else {
                          await getStat(phone);
                          if (successCode == '1') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                  phone: phone,
                                  type: type,
                                ),
                              ),
                            );
                          } else {
                            showSnackbar('User not exist! Sign Up');
                          }
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'Dont have an account ?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff40bf19),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
