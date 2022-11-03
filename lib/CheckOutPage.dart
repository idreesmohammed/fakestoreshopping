import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'CartData.dart';

class CheckOutPage extends StatefulWidget {
  // const CheckOutPage({Key? key}) : super(key: key);
  String from = "";

  CheckOutPage({required this.from});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  void initState() {
    super.initState();
    print('CheckOutPage: ' + widget.from);
    if (widget.from == 'CartDetailPage' || widget.from == 'CardViewPage') {
      CartData.myCartList.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child:
                    Lottie.asset('assets/lottie/checkout.json', repeat: false)),
            Text(
              'Your order has been placed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
