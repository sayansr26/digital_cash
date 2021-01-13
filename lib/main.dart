import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home.dart';
import 'pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Cash 24',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AssetImage splashBg = AssetImage('assets/images/splash-bg.png');
  AssetImage logo = AssetImage('assets/images/logo.png');

  bool hasPhone = false;

  Future<void> getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    if (phone != null) {
      setState(() {
        hasPhone = true;
      });
    } else {
      setState(() {
        hasPhone = false;
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    getPhone();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => hasPhone ? HomePage() : SignUpPage(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: splashBg,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: logo,
              width: 200,
              height: 200,
            ),
            Text(
              'Digital Cash 24',
              style: TextStyle(
                fontFamily: 'RacingSansOne',
                fontSize: 26,
                color: Color(0xff707070),
              ),
            ),
            Text(
              'Hand crafted wallet',
              style: TextStyle(
                fontFamily: 'RacingSansOne',
                fontWeight: FontWeight.w200,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
