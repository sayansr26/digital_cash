import 'package:digital_cash/pages/home.dart';
import 'package:digital_cash/widgets/buttongetstarted.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThankYou extends StatefulWidget {
  final String paymentId, orderId, amount, charge, total, status;
  ThankYou({
    @required this.paymentId,
    @required this.orderId,
    @required this.amount,
    @required this.charge,
    @required this.total,
    @required this.status,
  });
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff707070),
        ),
        title: Text(
          'Thank You',
          style: TextStyle(
            color: Color(0xff707070),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/confirm.json'),
            Text(
              'Transection Sucessfull',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Transection Id',
              style: TextStyle(
                color: Color(0xff707070),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.orderId,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Amount Paid',
              style: TextStyle(
                color: Color(0xff707070),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '₹ ${widget.total}',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
                fontSize: 30,
                fontFamily: 'Changa',
              ),
            ),
            ButtonGetStarted(
              buttonText: 'Back To Home',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
