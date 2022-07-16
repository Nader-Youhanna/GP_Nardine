import 'menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String name;
  final String email;
  final String gender;
  final String phone;
  final String carLicense;
  final String carBrand;
  final String carColour;

  HomePage({
    required this.name,
    required this.token,
    required this.email,
    required this.gender,
    required this.phone,
    required this.carLicense,
    required this.carBrand,
    required this.carColour,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = "Rakeny";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        //backgroundColor: Colors.orangeAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'images/logorakeny.PNG',
              color: Colors.white.withOpacity(0.2),
              colorBlendMode: BlendMode.modulate,
            )
          ],
        ),
      ),
      drawer: Menu(
        name: widget.name,
        email: widget.email,
        gender: widget.gender,
        token: widget.token,
        phone: widget.phone,
        carLicense: widget.carLicense,
        carBrand: widget.carBrand,
        carColour: widget.carColour,
      ),
    );
  }
}
