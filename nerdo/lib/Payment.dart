import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'CreditCard.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
}

void _goToCreditCard(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(builder: (_) {
      return CreditCard();
    }),
  );
}

void _goBack(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class _PaymentState extends State<Payment> {
  bool isAndroid = true;

  double screenWidth = 0;
  double screenHeight = 0;

  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Payment",
                style: TextStyle(
                    //fontFamily: 'RalewayMedium',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            _goBack(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.monetization_on),
                  title: const Text(
                    'Cash',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _goToCreditCard(context);
                  },
                  leading: const Icon(Icons.credit_card),
                  title: const Text(
                    'Credit Card',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
