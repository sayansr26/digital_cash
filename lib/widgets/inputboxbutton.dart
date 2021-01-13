import 'package:flutter/material.dart';

class InputBoxWithButton extends StatelessWidget {
  InputBoxWithButton({
    @required this.controller,
    @required this.iconData,
    @required this.placeholder,
    @required this.buttonText,
    @required this.onPressed,
  });
  final TextEditingController controller;
  final IconData iconData;
  final String placeholder, buttonText;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // color: Color(0xff707070),
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            iconData,
            size: 18,
            color: Color(0xff707070),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                hintText: placeholder,
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xff40bf19),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
