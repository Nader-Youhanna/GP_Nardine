import 'package:flutter/material.dart';

void _goBack(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class CreditCard extends StatelessWidget {
  const CreditCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf8b323),
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Credit Card",
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(width: 20),
                Expanded(
                  child: Image(
                    image: AssetImage('images/cvv.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Name on Card',
                  labelStyle: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      labelStyle: TextStyle(
                        fontFamily: 'RalewayMedium',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 170,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 3,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Security Code (CVV)',
                      labelStyle: TextStyle(
                        fontFamily: 'RalewayMedium',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
