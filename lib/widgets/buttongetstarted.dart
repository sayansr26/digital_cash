import 'package:flutter/material.dart';

class ButtonGetStarted extends StatelessWidget {
  ButtonGetStarted({@required this.buttonText, @required this.onPressed});
  final String buttonText;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Color(0xffff7a7a),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
