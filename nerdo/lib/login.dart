import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void _goToHomePage(
  BuildContext ctx,
  String token,
  String name,
) async {
  var url = Uri.parse('http://$IP_ADDRESS/get_user_data');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        "token": token,
      },
    ),
  );
  final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;

  String email = extractedMyInfo['email'];
  String gender = extractedMyInfo['gender'];
  String phone = extractedMyInfo['phone'];
  String carLicense = extractedMyInfo['carLicense'];
  String carBrand = extractedMyInfo['carBrand'];
  String carColour = extractedMyInfo['carColour'];
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return HomePage(
          token: token,
          name: name,
          email: email,
          gender: gender,
          phone: phone,
          carLicense: carLicense,
          carBrand: carBrand,
          carColour: carColour,
        );
      },
    ),
  );
}

///This is the login page
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String token = "";
  bool _passwordIsVisible = false;
  bool _nameIsEntered = false;
  bool _passwordIsEntered = false;
  String _name = '';
  String _email = '';
  String _password = '';
  bool _requestIsSent = false;
  bool _credentialsAreValid = false;

  double screenWidth = 0;
  double screenHeight = 0;

  final _passwordKey = GlobalKey<FormState>();

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<bool> _httpRequest(String username, String password) async {
    var url = Uri.parse('http://$IP_ADDRESS/login');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "name": username,
          "password": password,
        },
      ),
    );

    _requestIsSent = true;

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;

    if (extractedMyInfo['success'] == true) {
      _credentialsAreValid = true;
      token = extractedMyInfo['token'];
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(
      () {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xFFf8b323),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 29,
                  ),
                  onPressed: () {
                    _goBack(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.18,
                ),
                const Center(
                  child: Image(
                    image: AssetImage('images/logorakeny.PNG'),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.27,
                ),
                const Text(
                  'Welcome back!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'RalewayMedium',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 104, 42, 0),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              width: screenWidth * 0.84,
              child: TextField(
                onSubmitted: (u) {
                  _name = u;
                },
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.7,
                      color: Color.fromARGB(248, 199, 33, 4),
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF7b2e07),
                    ),
                  ),
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    fontFamily: 'RalewayMedium',
                    color: Color(0xFF7b2e07),
                    fontSize: 17,
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _name = value;
                    setState(
                      () {
                        _nameIsEntered = true;
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            SizedBox(
              width: screenWidth * 0.84,
              child: Form(
                key: _passwordKey,
                child: TextFormField(
                  validator: (_) {
                    return (_requestIsSent && !_credentialsAreValid)
                        ? 'Name or password is incorrect'
                        : null;
                  },
                  onFieldSubmitted: (_) {
                    setState(
                      () {
                        _passwordKey.currentState!.validate();
                      },
                    );
                  },
                  obscureText: !_passwordIsVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            _passwordIsVisible = !_passwordIsVisible;
                          },
                        );
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: _passwordIsVisible
                            ? Colors.black
                            : Colors.grey.shade700,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.7,
                        color: Color.fromARGB(248, 199, 33, 4),
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'RalewayMedium',
                      color: Color(0xFF7b2e07),
                      fontSize: 17,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF7b2e07),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _password = value;
                      setState(
                        () {
                          _passwordIsEntered = true;
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            /***************************** */
            SizedBox(
              height: screenHeight * 0.21,
            ),
            const Divider(
              height: 2,
              thickness: 1.1,
              color: Color.fromARGB(255, 112, 38, 2),
            ),
            SizedBox(height: screenHeight * 0.007),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenHeight * (8 / 360),
                ),
                ElevatedButton(
                  onPressed: () {
                    //_forgotPassword(context);
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 221, 190, 88),
                    ),
                    shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder(
                        side: BorderSide(
                          color: Color.fromARGB(255, 212, 155, 31),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'RalewayMedium',
                    ),
                  ),
                ),
                //const SizedBox(width: 125),
                SizedBox(
                  width: screenWidth * 0.31,
                ),
                ElevatedButton(
                  onPressed: () {
                    _httpRequest(_name, _password).then(
                      (success) {
                        if (success) {
                          _goToHomePage(
                            context,
                            token,
                            _name,
                          );
                        }
                        setState(
                          () {
                            _passwordKey.currentState!.validate();
                          },
                        );
                      },
                    );
                  },
                  style: (!(_passwordIsEntered && _nameIsEntered))
                      ? ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 221, 190, 88),
                          ),
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 212, 155, 31),
                                width: 1,
                              ),
                            ),
                          ),
                        )
                      : ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 104, 42, 0),
                          ),
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 212, 155, 31),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'RalewayMedium',
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
