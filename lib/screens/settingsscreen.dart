import 'package:digital_cash/widgets/settingsitems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AssetImage logo = AssetImage('assets/images/logo.png');

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: logo,
              height: 100,
              width: 100,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Digital Cash 24',
            style: TextStyle(
              color: Color(0xff707070),
              fontFamily: 'RacingSansOne',
              fontSize: 18,
            ),
          ),
          Text(
            'Hand crafted wallet',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'RacingSansOne',
            ),
          ),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              color: Color(0xff707070),
            ),
          ),
          SizedBox(height: 20),
          SettingsItems(
            title: 'Check for update',
            icon: FontAwesome5Solid.history,
            onPressed: () {
              _launchURL(
                  'https://play.google.com/store/apps/details?id=com.siaaw.wallpaper_plus');
            },
          ),
          SettingsItems(
            title: 'Share app',
            icon: FontAwesome5Solid.share,
            onPressed: () async {
              await FlutterShare.share(
                title: 'Check out this cool app',
                text: ' Transfer zest wallet balance to your bank account',
                linkUrl:
                    'https://play.google.com/store/apps/details?id=com.siaaw.wallpaper_plus',
              );
            },
          ),
          SettingsItems(
            title: 'Rate us',
            icon: FontAwesome5Solid.star,
            onPressed: () {
              _launchURL(
                  'https://play.google.com/store/apps/details?id=com.siaaw.wallpaper_plus');
            },
          ),
          SettingsItems(
            title: 'Call us',
            icon: FontAwesome5Solid.phone,
            onPressed: () {
              int phone = 916289572156;
              _launchURL('tel://$phone');
            },
          ),
        ],
      ),
    );
  }
}
