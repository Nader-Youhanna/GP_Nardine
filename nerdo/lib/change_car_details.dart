import 'package:flutter/material.dart';
import 'login.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void _goBack(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class ChangeCarDetails extends StatefulWidget {
  final String token;
  ChangeCarDetails({required this.token});
  @override
  State<ChangeCarDetails> createState() => _ChangeCarDetailsState();
}

class _ChangeCarDetailsState extends State<ChangeCarDetails> {
  String _carLicence = '';
  String _carBrand = '';
  String _carColour = '';
  Future<void> _httpRequest(
    String newCarLicence,
    String newCarBrand,
    String newCarColour,
    String token,
  ) async {
    var url = Uri.parse('http://$IP_ADDRESS/change_car_details');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "newCarLicence": newCarLicence,
          "newCarBrand": newCarBrand,
          "newCarColour": newCarColour,
          "token": token,
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

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
                text: "Change Car Info",
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
          Column(
            children: <Widget>[
              const ListTile(
                title: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'RalewayMedium',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 320,
                child: TextField(
                  onChanged: (value) {
                    _carLicence = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Car License',
                    labelStyle: TextStyle(fontFamily: 'RalewayMedium'),
                  ),
                ),
              ),
              SizedBox(
                width: 320,
                child: TextField(
                  onChanged: (value) {
                    _carBrand = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Car Brand',
                    labelStyle: TextStyle(fontFamily: 'RalewayMedium'),
                  ),
                ),
              ),
              SizedBox(
                width: 320,
                child: TextField(
                  onChanged: (value) {
                    _carColour = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Car Colour',
                    labelStyle: TextStyle(fontFamily: 'RalewayMedium'),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 238, 168, 15),
                ),
                onPressed: () {
                  _httpRequest(
                    _carLicence,
                    _carBrand,
                    _carColour,
                    widget.token,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
