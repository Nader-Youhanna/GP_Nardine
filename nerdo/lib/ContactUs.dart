import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ContactUS extends StatefulWidget {
  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  bool isAndroid = true;

  double screenWidth = 0;
  double screenHeight = 0;

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Contact Us",
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
              children: const <Widget>[
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text('https://www.facebook.com/RakenyParking'),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.whatsapp,
                    color: Colors.green,
                  ),
                  title: Text(
                    'Whatsapp',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  //trailing: Text('+201288500357'),
                  subtitle: Text('+201288500357'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
