import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void _goToHomePage(
  BuildContext ctx,
  String token,
  String name,
  String email,
  String gender,
  String phone,
  String carLicense,
  String carBrand,
  String carColour,
) {
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

class SignUp extends StatefulWidget {
  static const _widthOfTextFields = 320.0;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String token = "";
  Future<bool> _httpRequest(
    String name,
    String password,
    String email,
    String carlic,
    String brand,
    String colour,
    String mobile,
    String nationalid,
    String gender,
  ) async {
    var url = Uri.parse('http://$IP_ADDRESS/signup');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "name": name,
          "password": password,
          "email": email,
          "carlic": carlic,
          "brand": brand,
          "colour": colour,
          "mobile": mobile,
          "nationalid": nationalid,
          "gender": gender,
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
          if (extractedMyInfo['not_unique'] == 'name') {
            _nameIsUnique = false;
            _nameKey.currentState!.validate();
          } else if (extractedMyInfo['not_unique'] == 'email') {
            _emailIsUnique = false;
            _emailKey.currentState!.validate();
          }
        },
      );
      return false;
    }
  }

  void checkIfAllIsEntered() {
    _allIsEntered = (_nameIsEntered &&
        _passwordIsEntered &&
        _emailIsEntered &&
        _emailIsValid &&
        _carLicenceIsEntered &&
        _carBrandIsEntered &&
        _carColourIsEntered &&
        _mobileNumIsEntered &&
        _nationalIDIsEntered &&
        _genderIsEntered);
  }

  ///This function validates an email and returns a boolean
  bool isEmailValid(var email) {
    return (_emailIsValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email));
  }

  final _emailKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();

  var _allIsEntered = false;
  var _passwordIsEntered = false;
  var _carLicenceIsEntered = false;
  var _carBrandIsEntered = false;
  var _carColourIsEntered = false;
  var _mobileNumIsEntered = false;
  var _nationalIDIsEntered = false;
  var _emailIsEntered = false;
  var _nameIsEntered = false;
  var _emailIsValid = false;
  var _genderIsEntered = false;
  var _password;
  var _carLicense;
  var _carBrand;
  var _carColour;
  var _phone;
  var _nationalId;
  var _email;
  var _name;
  var _gender;
  String dropDownText = 'Prefer not to say';
  bool _nameIsUnique = true;
  bool _emailIsUnique = true;
  bool _requestIsSent = false;
  bool _passwordIsVisible = false;

  ///This is a navigation function that redirects to previous page
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  // void _goToChoosePassword(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(builder: (_) {
  //       return ChoosePassword(
  //         name: _name,
  //         username: _username,
  //         email: _email,
  //         dob: '${_dob.year}-${_dob.month}-${_dob.day}',
  //       );
  //     }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8b323),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 29,
                  ),
                  onPressed: () {
                    _goBack(context);
                  },
                ),

                //New logo
                const SizedBox(
                  width: 20,
                ),
                const Center(
                  child: Image(
                    image: AssetImage('images/logorakeny.PNG'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 320,
              child: Text(
                'Create your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'RalewayMedium',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Column(
              children: <Widget>[
                Form(
                  key: _nameKey,
                  child: SizedBox(
                    width: SignUp._widthOfTextFields,
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
                        _name = value;
                        setState(
                          () {
                            _nameIsEntered = value.isNotEmpty;
                            checkIfAllIsEntered();
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
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(
                        () {
                          _passwordIsEntered = value.isNotEmpty;
                          _password = value;
                          checkIfAllIsEntered();
                        },
                      );
                    },
                    obscureText: !_passwordIsVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
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
                    ),
                  ),
                ),
                Form(
                  key: _emailKey,
                  child: SizedBox(
                    width: SignUp._widthOfTextFields,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle:
                            const TextStyle(fontFamily: 'RalewayMedium'),
                        suffixIcon: (_emailIsValid && _emailIsEntered)
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              )
                            : (_emailIsEntered && !_emailIsValid)
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : null,
                      ),
                      validator: (_) {
                        return (_requestIsSent && !_emailIsUnique)
                            ? 'This email address is already taken'
                            : null;
                      },
                      onFieldSubmitted: (_) {
                        setState(
                          () {
                            _emailKey.currentState!.validate();
                          },
                        );
                      },
                      onChanged: (value) {
                        setState(
                          () {
                            _emailIsEntered = value.isNotEmpty;
                            _email = value;
                            _emailIsValid = isEmailValid(value);
                            checkIfAllIsEntered();
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextField(
                    onChanged: (value) {
                      setState(
                        () {
                          _carLicenceIsEntered = value.isNotEmpty;
                          _carLicense = value;
                          checkIfAllIsEntered();
                        },
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: (_carLicenceIsEntered)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : null,
                      labelText: 'Car license plate',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                    ),
                  ),
                ),
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextField(
                    onChanged: (value) {
                      _carBrand = value;
                      setState(
                        () {
                          _carBrandIsEntered = value.isNotEmpty;
                          checkIfAllIsEntered();
                        },
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Car brand/model',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                      suffixIcon: (_carBrandIsEntered)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextField(
                    onChanged: (value) {
                      setState(
                        () {
                          _carColour = value;
                          _carColourIsEntered = value.isNotEmpty;
                          checkIfAllIsEntered();
                        },
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Car colour',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                      suffixIcon: (_carColourIsEntered)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextField(
                    onChanged: (value) {
                      setState(
                        () {
                          _phone = value;
                          _mobileNumIsEntered = value.isNotEmpty;
                          checkIfAllIsEntered();
                        },
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Mobile number',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                      suffixIcon: (_mobileNumIsEntered)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: SignUp._widthOfTextFields,
                  child: TextField(
                    onChanged: (value) {
                      setState(
                        () {
                          _nationalIDIsEntered = value.isNotEmpty;
                          _nationalId = value;
                          checkIfAllIsEntered();
                        },
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'National Id',
                      labelStyle: const TextStyle(fontFamily: 'RalewayMedium'),
                      suffixIcon: (_nationalIDIsEntered)
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : null,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 40),
                    const Text(
                      'Gender: ',
                      style: TextStyle(
                        fontFamily: 'RalewayMedium',
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 30),
                    DropdownButton<String>(
                      value: dropDownText,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Color.fromARGB(255, 54, 37, 1),
                      ),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            dropDownText = newValue!;
                            _gender = newValue;
                            _genderIsEntered = true;
                            checkIfAllIsEntered();
                          },
                        );
                      },
                      items: <String>['Female', 'Male', 'Prefer not to say']
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const SizedBox(width: 280),
                ElevatedButton(
                  child: const Text('Next'),
                  onPressed: (_allIsEntered)
                      ? () {
                          _httpRequest(
                            _name,
                            _password,
                            _email,
                            _carLicense,
                            _carBrand,
                            _carColour,
                            _phone,
                            _nationalId,
                            _gender,
                          ).then(
                            (success) {
                              if (success) {
                                _goToHomePage(
                                  context,
                                  token,
                                  _name,
                                  _email,
                                  _gender,
                                  _phone,
                                  _carLicense,
                                  _carBrand,
                                  _carColour,
                                );
                              }
                            },
                          );
                        }
                      : () {},
                  style: (!_allIsEntered)
                      ? ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade400),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade600),
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(),
                          ),
                        )
                      : ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape: MaterialStateProperty.all<StadiumBorder>(
                            const StadiumBorder(),
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
