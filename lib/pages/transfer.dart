import 'dart:convert';

import 'package:digital_cash/models/accounmodel.dart';
import 'package:digital_cash/models/chargesmodel.dart';
import 'package:digital_cash/models/ordersmodel.dart';
import 'package:digital_cash/models/usermodel.dart';
import 'package:digital_cash/widgets/buttongetstarted.dart';
import 'package:digital_cash/widgets/inputbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'thankyou.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController amountController = new TextEditingController();
  TextEditingController banController = new TextEditingController();
  TextEditingController accountController = new TextEditingController();
  TextEditingController ifscController = new TextEditingController();
  TextEditingController bankController = new TextEditingController();
  TextEditingController chargesController = new TextEditingController();
  TextEditingController aBanificaryController = new TextEditingController();
  TextEditingController aAccountController = new TextEditingController();
  TextEditingController aCaccountController = new TextEditingController();
  TextEditingController aIfscController = new TextEditingController();
  TextEditingController aBankController = new TextEditingController();

  Razorpay razorpay = new Razorpay();

  double chargeAmount, chargeFinal, totalAmount, finalAmount;

  bool hasAccount = false;

  ChargesModel chargesModel = new ChargesModel();
  OrdersModel ordersModel = new OrdersModel();
  AccountModel accountModel = new AccountModel();
  UserModel userModel = new UserModel();

  getCharges() async {
    var response = await http.get(
      'https://tubeace.ml/get_exchnage_rate',
      headers: {"Accept": "application/json"},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    chargesModel = ChargesModel.fromMap(jsonData['result']);

    setState(() {});
  }

  getAccountDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    if (phone != null) {
      var response = await http.get(
        'https://tubeace.ml/account_details?phone=$phone',
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);

      accountModel = AccountModel.fromMap(jsonData['result']);
      // print(jsonData.toString());
      setState(() {});
      if (jsonData['success'] == '1') {
        hasAccount = true;
        banController.text = accountModel.banificary;
        accountController.text = accountModel.account;
        ifscController.text = accountModel.ifsc;
        bankController.text = accountModel.bankname;
      }
    }
  }

  getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    if (phone != null) {
      var response = await http.get(
        'https://tubeace.ml/get_user_data?phone=$phone',
        headers: {"Accept": "application/json"},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      userModel = UserModel.fromMap(jsonData['result']);

      setState(() {});
    }
  }

  createOrder() async {
    var headers = {
      'Content-type': 'application/json',
      'Authorization':
          'Basic cnpwX2xpdmVfSjMwaXlSSVRMMkR3Yk86NXVjemZEaTZNUk5GNDBrdEhWd01zWjhG'
    };
    var request =
        http.Request('POST', Uri.parse('https://api.razorpay.com/v1/orders'));
    request.body = '''{\n  "amount": $finalAmount,\n  "currency": "INR"\n}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var mainResponse = await http.Response.fromStream(response);
      Map<String, dynamic> jsonData = jsonDecode(mainResponse.body);
      ordersModel = OrdersModel.fromMap(jsonData);
      setState(() {});
      if (ordersModel.id != null) {
        openCheckOut();
      }
    } else {
      print(response.statusCode);
    }
  }

  openCheckOut() async {
    if (ordersModel.id != null) {
      var options = {
        'key': 'rzp_live_J30iyRITL2DwbO',
        'amount': finalAmount,
        'name': 'Digital Cash',
        'order_id': ordersModel.id.toString(),
        'description': 'Trasfer money',
        'timeout': 60,
        'image': 'https://avatars1.githubusercontent.com/u/35045612?s=400&v=4',
        'prefill': {'contact': userModel.phone, 'email': userModel.email},
        'external': {
          'wallets': ['paytm']
        }
      };

      try {
        razorpay.open(options);
      } catch (e) {
        print(e.toString());
      }
    } else {
      showSnackbar('Please wait');
    }
  }

  createAccount() async {
    if (userModel.phone != null) {
      var banificaryName = aBanificaryController.text;
      var accountNumber = aAccountController.text;
      var ifscCode = aIfscController.text;
      var bankName = aBankController.text;
      var phone = userModel.phone;

      var response = await http.get(
        'https://tubeace.ml/create_account?phone=$phone&banificary=$banificaryName&account=$accountNumber&ifsc=$ifscCode&bank_name=$bankName',
        headers: {'Accept': 'appliaction/json'},
      );

      Map<String, dynamic> jsonData = jsonDecode(response.body);

      setState(() {});

      if (jsonData['success'] == '1') {
        getAccountDetails();
      } else {
        showSnackbar('Error! try again');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCharges();
    getAccountDetails();
    getUserData();
    amountController.addListener(() {
      if (amountController.text != null) {
        chargeAmount = (num.parse(amountController.text) / 100);
        chargeFinal = num.parse(chargesModel.charge) * chargeAmount;
        chargesController.text = chargeFinal.toString();
        totalAmount = num.parse(amountController.text) +
            num.parse(chargesController.text);

        setState(() {});

        finalAmount = totalAmount * 100;
      }
    });
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    // showSnackbar(response.orderId);
    var amount = amountController.text;
    var charge = chargeFinal;
    var total = totalAmount;
    var username = userModel.username;
    var phone = userModel.phone;
    var ban = accountModel.banificary;
    var account = accountModel.account;
    var ifsc = accountModel.ifsc;
    var bank = accountModel.bankname;
    var razorpay = response.paymentId;
    var orderId = response.orderId;
    var type = '1';

    var request = await http.get(
      'https://tubeace.ml/create_transection?amount=$amount&charge=$charge&total=$total&username=$username&phone=$phone&ban=$ban&account=$account&ifsc=$ifsc&bank=$bank&razorpay=$razorpay&order_id=$orderId&type=$type',
      headers: {"Accept": "application/json"},
    );

    Map<String, dynamic> jsonData = jsonDecode(request.body);

    setState(() {});

    if (jsonData['success'] == '1') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThankYou(
            paymentId: razorpay,
            orderId: orderId,
            amount: amount,
            charge: charge.toString(),
            total: total.toString(),
            status: 'accepted',
          ),
        ),
      );
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    showSnackbar('Sorry payment faield');
  }

  void handleExternalWallet() {
    showSnackbar('Payment done with external wallet');
  }

  void showSnackbar(String content) {
    scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        duration: Duration(milliseconds: 3000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff707070),
        ),
        title: Text(
          'Transfer Money',
          style: TextStyle(
            color: Color(0xff707070),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hasAccount
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            InputBox(
                              controller: amountController,
                              iconData: FontAwesome5Solid.rupee_sign,
                              placeholder: 'Transfer amount',
                              textInputType: TextInputType.number,
                            ),
                            InputBox(
                              controller: banController,
                              iconData: FontAwesome5Solid.address_card,
                              placeholder: 'Banificary Name',
                              textInputType: TextInputType.text,
                              readOnly: true,
                            ),
                            InputBox(
                              controller: accountController,
                              iconData: FontAwesome5Solid.key,
                              placeholder: 'Account Number',
                              textInputType: TextInputType.text,
                              readOnly: true,
                            ),
                            InputBox(
                              controller: ifscController,
                              iconData: FontAwesome5Solid.anchor,
                              placeholder: 'IFSC Code',
                              textInputType: TextInputType.text,
                              readOnly: true,
                            ),
                            InputBox(
                              controller: bankController,
                              iconData: FontAwesome5Solid.address_book,
                              placeholder: 'Bank Name',
                              textInputType: TextInputType.text,
                              readOnly: true,
                            ),
                            InputBox(
                              controller: chargesController,
                              iconData: FontAwesome5Solid.rupee_sign,
                              placeholder: 'Charges',
                              textInputType: TextInputType.number,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Fill account details correctly',
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20),
                            InputBox(
                              controller: aBanificaryController,
                              iconData: FontAwesome5Solid.address_card,
                              placeholder: 'Banificary Name',
                              textInputType: TextInputType.name,
                            ),
                            InputBox(
                              controller: aAccountController,
                              iconData: FontAwesome5Solid.key,
                              placeholder: 'Account Number',
                              textInputType: TextInputType.number,
                            ),
                            InputBox(
                              controller: aCaccountController,
                              iconData: FontAwesome5Solid.key,
                              placeholder: 'Confirm Account Number',
                              textInputType: TextInputType.number,
                            ),
                            InputBox(
                              controller: aIfscController,
                              iconData: FontAwesome5Solid.anchor,
                              placeholder: 'IFSC Code',
                              textInputType: TextInputType.text,
                            ),
                            InputBox(
                              controller: aBankController,
                              iconData: FontAwesome5Solid.address_book,
                              placeholder: 'Bank Name',
                              textInputType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              ListTile(
                leading: Text(
                  'Note :',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff707070),
                  ),
                ),
                title: Text(
                  'You can only transfer money to your default bank account, for changes contact admin',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xff707070),
                  ),
                ),
              ),
              hasAccount
                  ? Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListTile(
                        leading: Icon(FontAwesome5Solid.rupee_sign),
                        title: Text(
                          'Total Amount',
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text('Charges are included',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            )),
                        trailing: (totalAmount != null)
                            ? Text(
                                '₹ $totalAmount',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  fontFamily: 'Changa',
                                ),
                              )
                            : Text(
                                '₹ 0.00',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  fontFamily: 'Changa',
                                ),
                              ),
                      ),
                    )
                  : Container(),
              hasAccount
                  ? ButtonGetStarted(
                      buttonText: 'Transfer Money',
                      onPressed: () {
                        if (amountController.text == '') {
                          showSnackbar('Transection Amount Required !');
                        } else {
                          createOrder();
                        }
                      },
                    )
                  : ButtonGetStarted(
                      buttonText: 'Add Account',
                      onPressed: () {
                        if (aBanificaryController.text == '') {
                          showSnackbar('Banificary Name required !');
                        } else if (aAccountController.text == '') {
                          showSnackbar('Accunt Number required !');
                        } else if (aCaccountController.text == '') {
                          showSnackbar('Confirm Accunt Number required !');
                        } else if (aCaccountController.text !=
                            aAccountController.text) {
                          showSnackbar('Accunt Number mismatch !');
                        } else if (aIfscController.text == '') {
                          showSnackbar('ISC Code required !');
                        } else if (aBankController.text == '') {
                          showSnackbar('Bank Name required !');
                        } else {
                          createAccount();
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
