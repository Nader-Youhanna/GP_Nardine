import 'package:flutter/material.dart';
import 'account_info.dart';
import 'car_details.dart';

class Profile extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String carLicense;
  final String carBrand;
  final String carColour;

  Profile({
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.carLicense,
    required this.carBrand,
    required this.carColour,
  });

  void _goBack(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  final List<String> _tabs = ["Account Info", "Car Details"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFf8b323),
          leading: BackButton(
            onPressed: () {
              _goBack(context);
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Account Info',
              ),
              Tab(
                icon: Icon(Icons.directions_car),
                text: 'Car Details',
              ),
            ],
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'RalewaylogMedium',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AccountInfo(
              username: name,
              phone: phone,
              email: email,
              gender: gender,
            ),
            CarDetails(
              carLicense: carLicense,
              carBrand: carBrand,
              carColour: carColour,
            ),
          ],
        ),
      ),
    );
  }
}
