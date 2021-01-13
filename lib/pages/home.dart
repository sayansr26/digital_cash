import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:digital_cash/screens/historyscreen.dart';
import 'package:digital_cash/screens/homescreen.dart';
import 'package:digital_cash/screens/profilescreen.dart';
import 'package:digital_cash/screens/settingsscreen.dart';
import 'package:digital_cash/screens/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List listOfScreens = [
    HomeScreen(),
    WalletScreen(),
    HistoryScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  DateTime current;
  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (current == null || now.difference(current) > Duration(seconds: 2)) {
      current = now;

      showSnackBar("Press again to exit");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void showSnackBar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 2000),
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
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        key: scaffoldState,
        body: listOfScreens[currentIndex],
        bottomNavigationBar: BottomNavyBar(
          curve: Curves.easeInOut,
          selectedIndex: currentIndex,
          onItemSelected: (index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(
                AntDesign.home,
                size: 25,
              ),
              textAlign: TextAlign.center,
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              activeColor: Color(0xffa3d593),
              inactiveColor: Color(0xff707070),
            ),
            BottomNavyBarItem(
              icon: Icon(
                AntDesign.wallet,
                size: 25,
              ),
              textAlign: TextAlign.center,
              title: Text(
                'Wallet',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              activeColor: Color(0xffa3d593),
              inactiveColor: Color(0xff707070),
            ),
            BottomNavyBarItem(
              icon: Icon(
                AntDesign.sync,
                size: 25,
              ),
              textAlign: TextAlign.center,
              title: Text(
                'History',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              activeColor: Color(0xffa3d593),
              inactiveColor: Color(0xff707070),
            ),
            BottomNavyBarItem(
              icon: Icon(
                AntDesign.user,
                size: 25,
              ),
              textAlign: TextAlign.center,
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              activeColor: Color(0xffa3d593),
              inactiveColor: Color(0xff707070),
            ),
            BottomNavyBarItem(
              icon: Icon(
                AntDesign.setting,
                size: 25,
              ),
              textAlign: TextAlign.center,
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              activeColor: Color(0xffa3d593),
              inactiveColor: Color(0xff707070),
            ),
          ],
        ),
      ),
    );
  }
}
