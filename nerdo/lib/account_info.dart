import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  final String username;
  final String phone;
  final String email;
  final String gender;

  AccountInfo({
    required this.username,
    required this.phone,
    required this.email,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            widthFactor: 0.5,
            heightFactor: 1,
            child: Image.asset(
              gender == 'Male'
                  ? 'images/male_icon.jpg'
                  : 'images/female_icon.jpg',
              //  fit: BoxFit.scaleDown,
              height: 200,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Text(username),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Phone',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                phone,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Email',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              trailing: Text(
                email,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
