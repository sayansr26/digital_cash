import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TransectionItems extends StatelessWidget {
  TransectionItems({
    @required this.transferType,
    @required this.transferDate,
    @required this.transferAmount,
    this.onPressed,
  });
  final String transferType, transferDate, transferAmount;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xffa3d593),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 25,
                width: 25,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transferType,
                    style: TextStyle(
                      color: Color(0xffff7a7a),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    transferDate,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              transferAmount,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: 'Changa',
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Entypo.arrow_with_circle_right,
              color: Color(0xffff7a7a),
            ),
          ],
        ),
      ),
    );
  }
}
