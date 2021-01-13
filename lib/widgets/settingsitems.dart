import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SettingsItems extends StatelessWidget {
  SettingsItems({
    @required this.title,
    @required this.icon,
    @required this.onPressed,
  });
  final String title;
  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xfff0f0f0),
        borderRadius: BorderRadius.circular(35),
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
        onTap: onPressed,
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff707070),
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Icon(
          FontAwesome5Solid.arrow_alt_circle_right,
        ),
      ),
    );
  }
}
