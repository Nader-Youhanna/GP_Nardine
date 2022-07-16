import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'login.dart';

void _goBack(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class ChangeUsername extends StatefulWidget {
  String name = '';
  String token;

  ChangeUsername({
    required this.token,
    required this.name,
  });

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  String _newUsername = '';
  bool _requestIsSent = false;

  bool _nameIsUnique = true;

  bool _nameIsEntered = false;
  final _nameKey = GlobalKey<FormState>();

  Future<bool> _httpRequest(
    String newName,
    String token,
  ) async {
    print('newName = $newName');
    var url = Uri.parse('http://$IP_ADDRESS/change_username');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "newName": newName,
          "token": token,
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;

    _requestIsSent = true;

    if (extractedMyInfo['success'] == true) {
      token = extractedMyInfo['token'];
      return true;
    } else {
      setState(
        () {
          _nameIsUnique = false;
          _nameKey.currentState!.validate();
        },
      );
      return false;
    }
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
                text: "Change Username",
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
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Your current username is: ${widget.name}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'RalewayMedium',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _nameKey,
                  child: SizedBox(
                    width: 320,
                    child: TextFormField(
                      validator: (value) {
                        return (_requestIsSent && !_nameIsUnique)
                            ? 'This name is already taken'
                            : null;
                      },
                      onFieldSubmitted: (_) {
                        setState(
                          () {
                            _nameKey.currentState!.validate();
                          },
                        );
                      },
                      onChanged: (value) {
                        _newUsername = value;
                        setState(
                          () {
                            _nameIsEntered = value.isNotEmpty;
                          },
                        );
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (_requestIsSent)
                            ? (_nameIsEntered && _nameIsUnique)
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : (_nameIsEntered)
                                    ? const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      )
                                    : null
                            : (_nameIsEntered)
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                : (_nameIsEntered)
                                    ? const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      )
                                    : null,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 238, 168, 15),
                  ),
                  onPressed: () {
                    _httpRequest(_newUsername, widget.token);
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
