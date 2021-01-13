import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  InputBox({
    @required this.controller,
    @required this.iconData,
    @required this.placeholder,
    @required this.textInputType,
    this.readOnly = false,
    this.onChaged,
  });
  final TextEditingController controller;
  final IconData iconData;
  final String placeholder;
  final TextInputType textInputType;
  final bool readOnly;
  final CallbackAction onChaged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      margin: EdgeInsets.symmetric(
        vertical: 2,
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
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: textInputType,
              readOnly: readOnly,
              textInputAction: TextInputAction.next,
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
        ],
      ),
    );
  }
}
