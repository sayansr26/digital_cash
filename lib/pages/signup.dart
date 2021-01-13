import 'dart:convert';

import 'package:digital_cash/pages/signin.dart';
import 'package:digital_cash/widgets/buttongetstarted.dart';
import 'package:digital_cash/widgets/formtitle.dart';
import 'package:digital_cash/widgets/inputbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

import 'otp.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  AssetImage bgImage = AssetImage('assets/images/signup-bg.png');
  AssetImage logo = AssetImage('assets/images/logo.png');

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String fname, lname, username, email, phone, type;

  String successCode = "";

  getStat(String phone) async {
    var response = await http.get(
      "https://tubeace.ml/check_stat?phone=$phone",
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
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: scaffoldState,
      backgroundColor: Color(0xfff0f0f0),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height / 3.6,
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
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Digital Cash 24',
                    style: TextStyle(
                      fontFamily: 'RacingSansOne',
                      fontSize: 18,
                      color: Color(0xff707070),
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
            height: size.height / 1.3,
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
                    title: 'Create Account',
                    subTitle: 'Create an account to get started',
                  ),
                  InputBox(
                    controller: _fNameController,
                    textInputType: TextInputType.name,
                    iconData: FontAwesome5Solid.user_check,
                    placeholder: 'First Name',
                  ),
                  InputBox(
                    controller: _lNameController,
                    textInputType: TextInputType.name,
                    iconData: FontAwesome5Solid.user_check,
                    placeholder: 'Last Name',
                  ),
                  InputBox(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    iconData: FontAwesome5Solid.envelope,
                    placeholder: 'Email Address',
                  ),
                  InputBox(
                    controller: _usernameController,
                    textInputType: TextInputType.text,
                    iconData: FontAwesome5Solid.user,
                    placeholder: 'Username',
                  ),
                  InputBox(
                    controller: _phoneController,
                    textInputType: TextInputType.phone,
                    iconData: FontAwesome5Solid.phone,
                    placeholder: 'Phone',
                  ),
                  Center(
                    child: ButtonGetStarted(
                      buttonText: 'Sign Up',
                      onPressed: () async {
                        setState(() {
                          fname = _fNameController.text;
                          lname = _lNameController.text;
                          username = _usernameController.text;
                          email = _emailController.text;
                          phone = _phoneController.text;
                          type = '1';
                        });
                        if (fname == '') {
                          showSnackbar('First name required');
                        } else if (lname == '') {
                          showSnackbar('Last name required');
                        } else if (email == '') {
                          showSnackbar('Username required');
                        } else if (username == '') {
                          showSnackbar('email required');
                        } else if (phone == '') {
                          showSnackbar('Phone required');
                        } else {
                          await getStat(phone);
                          if (successCode == '1') {
                            showSnackbar('Phone number already exist');
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                  fname: fname,
                                  lname: lname,
                                  email: email,
                                  username: username,
                                  phone: phone,
                                  type: type,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'Already have an account ?',
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
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
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
