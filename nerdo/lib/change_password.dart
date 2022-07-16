import 'package:flutter/material.dart';
import 'login.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void _goBack(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class ChangePassword extends StatefulWidget {
  final String token;
  ChangePassword({required this.token});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Future<void> _httpRequest(
    String newPassword,
    String token,
  ) async {
    var url = Uri.parse('http://$IP_ADDRESS/change_password');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "newPassword": newPassword,
          "token": token,
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  String _newPassword = '';
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
                text: "Change Password",
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
                      _newPassword = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'RalewayMedium'),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 238, 168, 15),
                  ),
                  onPressed: () {
                    _httpRequest(_newPassword, widget.token);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return Login();
                      }),
                    );
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
          ),
        ],
      ),
    );
  }
}
