import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({
    this.fname,
    this.lname,
    this.username,
    this.email,
    @required this.phone,
    @required this.type,
  });
  final String fname, lname, username, email, phone, type;
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _otpController = TextEditingController();
  FocusNode _otpFocusNode = FocusNode();
  String _verificationCode;
  BoxDecoration otpBoxDecoration = BoxDecoration(
    color: Color(0xfff0f0f0),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Color(0xfff0f0f0),
    ),
  );

  String fname, lname, email, username, phone, type, successCode;

  userAction() async {
    var fname = widget.fname;
    var lname = widget.lname;
    var email = widget.email;
    var username = widget.username;
    var phone = widget.phone;
    var type = widget.type;

    if (type == '1') {
      var response = await http.get(
        'https://tubeace.ml/register_user?fname=$fname&lname=$lname&email=$email&username=$username&phone=$phone',
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);

      setState(() {
        successCode = jsonData['success'];
      });

      // print(jsonData);
    } else {
      var response = await http.get(
        'https://tubeace.ml/login_user?phone=$phone',
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);

      setState(() {
        successCode = jsonData['success'];
      });
    }
  }

  void showSnackbar(String content) {
    _scaffoldKey.currentState.showSnackBar(
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xff707070),
        ),
        title: Text(
          'OTP Verification',
          style: TextStyle(
            color: Color(0xff707070),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Verify +91 ${widget.phone}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff707070),
                fontSize: 28,
                fontFamily: 'Changa',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: Text(
              'Enter OTP or wait for autoverify',
              style: TextStyle(
                color: Color(0xff707070),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(
                color: Color(0xff333333),
                fontSize: 25,
              ),
              eachFieldWidth: 40,
              eachFieldHeight: 55,
              focusNode: _otpFocusNode,
              controller: _otpController,
              submittedFieldDecoration: otpBoxDecoration,
              selectedFieldDecoration: otpBoxDecoration,
              followingFieldDecoration: otpBoxDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(
                    PhoneAuthProvider.credential(
                      verificationId: _verificationCode,
                      smsCode: pin,
                    ),
                  )
                      .then(
                    (value) async {
                      if (value.user != null) {
                        await userAction();
                        if (successCode == '1') {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setString('phone', widget.phone);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false);
                        } else {
                          showSnackbar('Error 500 ! try again');
                        }
                      }
                    },
                  );
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  showSnackbar('Invalid OTP !');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) async {
            if (value.user != null) {
              await userAction();
              if (successCode == '1') {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('phone', widget.phone);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false);
              } else {
                showSnackbar('Error 500 ! try again');
              }
            }
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String varificationID, int resendToken) {
        setState(() {
          _verificationCode = varificationID;
        });
        showSnackbar('OTP Sent Successfully !');
      },
      codeAutoRetrievalTimeout: (String varificationID) {
        _verificationCode = varificationID;
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
